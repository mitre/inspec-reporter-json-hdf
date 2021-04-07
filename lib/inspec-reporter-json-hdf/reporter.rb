
require 'inspec/plugin/v2'
require 'json'

VALID_FREQUENCY = %w[annually semiannually quarterly monthly every2weeks weekly every3days daily].freeze

VALID_STATUSES = %w[passed failed].freeze

DATE_FORMAT = '%Y-%m-%d'.freeze

module InspecPlugins::HdfReporter
  # Reporter Plugin Class
  class Reporter < Inspec.plugin(2, :reporter)
    def render
      output(report.to_json, false)
    end

    def self.run_data_schema_constraints
      '~> 0.0' # Accept any non-breaking change
    end

    def report
      report = Inspec::Reporters::Json.new(@config).report
      attestations = collect_attestations

      report[:profiles].each do |profile|
        profile[:controls].each do |control|
          attestation = attestations.detect { |x| x['control_id'].eql?(control[:id]) }

          next if attestation.nil?

          control[:attestation] = attestation
          unless attestation_expired?(attestation['updated'], attestation['frequency'])
            control[:results] = apply_attestation(control[:results], attestation)
          end
        end
      end
      report
    end

    private

    def apply_attestation(results, attestation)
      if results.empty?
        results = [{
          "code_desc": 'Manually verified Status provided through attestation',
          "run_time": 0.0,
          "start_time": DateTime.now.to_s,
          "status": attestation['status'],
          "message": attestation_message(attestation)
        }]
      else
        results.each do |result|
          result[:message] = 'Automated test returned as passed.' if result[:status].eql?('passed')
          result[:message] = result[:skip_message] if result[:status].eql?('skipped')

          result[:status] = attestation['status']
          result[:message] = result[:message] + attestation_message(attestation)

          if result[:backtrace]
            result[:message] = result[:message] + "\nbacktrace: #{result[:backtrace]}"
            result[:backtrace] = nil
          end
        end
      end
      results
    end

    def attestation_message(attestation)
      "
       Attestation:
       Status: #{attestation['status']}
       Explanation: #{attestation['explanation']}
       Updated: #{attestation['updated']}
       Updated By: #{attestation['updated_by']}
       Frequency: #{attestation['frequency']}
       "
    end

    def attestation_expired?(date, frequency)
      advanced_date(date, frequency) < DateTime.now
    end

    def advanced_date(date, frequency)
      parsed_date = DateTime.strptime('2021-01-12', DATE_FORMAT)
      puts parsed_date
      case frequency.downcase
      when 'annually'
        tmp = parsed_date.next_year(1)
        puts tmp
        tmp
      when 'semiannually'
        tmp = parsed_date.next_year(0.5)
        puts tmp
        tmp
      when 'quarterly'
        tmp = parsed_date.next_year(0.25)
        puts tmp
        tmp
      when 'monthly'
        tmp = parsed_date.next_month(1)
        puts tmp
        tmp
      when 'every2weeks'
        parsed_date.next_day(14)
      when 'weekly'
        parsed_date.next_day(7)
      when 'every3days'
        parsed_date.next_day(3)
      when 'daily'
        parsed_date.next_day(1)
      else
        parsed_date
      end
    end

    # Check if its a valid Date and Date not in future.
    def valid_date?(date)
      DateTime.strptime(date, DATE_FORMAT) < DateTime.now
    rescue ArgumentError
      false
    end

    def valid_frequency?(frequency)
      frequency.is_a?(String) && VALID_FREQUENCY.include?(frequency.downcase)
    end

    def valid_status?(status)
      status.is_a?(String) && VALID_STATUSES.include?(status.downcase)
    end

    def collect_attestations
      plugin_config = Inspec::Config.cached.fetch_plugin_config('inspec-reporter-json-hdf')
      attestations = plugin_config['attestations'] || []

      if attestations.empty?
        puts 'Warning: Attestations not provided; HDF will be generated without attestations.'
      else
        validate_attestation(attestations)
      end
      attestations
    end

    def validate_attestation(attestations)
      attestations.each do |attestation|
        unless attestation['control_id'].is_a?(String)
          raise "Error: Invalid `control_id` field at attestation: #{attestation}."
        end
        unless valid_status?(attestation['status'])
          raise "Error: Invalid `status` field at attestation: #{attestation}."
        end
        unless attestation['updated_by'].is_a?(String)
          raise "Error: Invalid `updated_by` field at attestation: #{attestation}."
        end
        unless attestation['explanation'].is_a?(String)
          raise "Error: Invalid `explanation` field at attestation: #{attestation}."
        end
        unless valid_frequency?(attestation['frequency'])
          raise "Error: Invalid `frequency` field at attestation: #{attestation}."
        end
        unless valid_date?(attestation['updated'])
          raise "Error: Invalid `updated` field at attestation: #{attestation}."
        end

        if attestation_expired?(attestation['updated'], attestation['frequency'])
          puts "Warning: Attestation Expired : #{attestation}"
        end
      end
    end
  end
end
