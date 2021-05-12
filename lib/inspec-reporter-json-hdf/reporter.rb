
require 'inspec/plugin/v2'
require 'json'
require 'roo'

VALID_FREQUENCY = %w[annually semiannually quarterly monthly every2weeks weekly every3days daily].freeze

VALID_STATUSES = %w[passed failed].freeze

DATE_FORMAT = '%Y-%m-%d'.freeze

SUPPORTED_INCLUDE_TYPES = %w[csv xlsx].freeze

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
          control[:results] = apply_attestation(control[:results], attestation)
        end
      end
      report
    end

    private

    def apply_attestation(results, attestation)
      result_block = {}
      if attestation_expired?(attestation['updated'], attestation['frequency'])
        result_block['code_desc']= 'Manual verification status via attestation has expired'
        result_block['status']= 'skipped'
      else
        result_block['code_desc']= 'Manually verified Status provided through attestation'
        result_block['status']= attestation['status']
      end
      result_block['run_time']= 0.0
      result_block['start_time']= DateTime.now.to_s
      result_block['message']= attestation_message(attestation)
      results << result_block
    end

    def attestation_message(attestation)
      msg = []
      msg << 'Attestation:'
      if attestation_expired?(attestation['updated'], attestation['frequency'])
        msg << "Expired Status: #{attestation['status']}"
      else
        msg << "Status: #{attestation['status']}"
      end
      msg << "Explanation: #{attestation['explanation']}"
      msg << "Updated: #{attestation['updated']}"
      msg << "Updated By: #{attestation['updated_by']}"
      msg << "Frequency: #{attestation['frequency']}"
      msg.join("\n")
    end

    def attestation_expired?(date, frequency)
      advanced_date(date, frequency) < DateTime.now
    end

    def advanced_date(date, frequency)
      parsed_date = DateTime.strptime(date, DATE_FORMAT)

      case frequency.downcase
      when 'annually'
        parsed_date.next_year(1)
      when 'semiannually'
        parsed_date.next_month(6)
      when 'quarterly'
        parsed_date.next_month(3)
      when 'monthly'
        parsed_date.next_month(1)
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

    def parse_include_file(include_file)
      if File.exist?(include_file['path'])
        if SUPPORTED_INCLUDE_TYPES.include?(include_file['type'])
          sheet = Roo::Spreadsheet.open(include_file['path'], extension: include_file['type'].to_sym ).sheet(0)
          
          attestations = sheet.parse(control_id: "Control_ID",
                                     explanation: "Explanation",
                                     frequency: "Frequency",
                                     status: "Status",
                                     updated: "Updated",
                                     updated_by: "Updated_By",
                                     clean:true
                                     )
          # Following is required to convert Datetime field returned by xlsx parser to string
          attestations.map do |h|
            h[:updated] = h[:updated].to_s
          end
        else
          puts "Warning: Invalid `include-attestations-file` type provided. Supported types: #{SUPPORTED_INCLUDE_TYPES.to_s}"
        end
      else
        puts "Warning: Include Attestation File provided  '#{include_file['path']}' not found."
      end
      attestations || []
    end

    def collect_attestations
      plugin_config = Inspec::Config.cached.fetch_plugin_config('inspec-reporter-json-hdf')
      attestations = []

      # Parse Attestations from include file.
      attestations = parse_include_file(plugin_config['include-attestations-file']) if plugin_config['include-attestations-file']

      attestations.map!{ |x| x.transform_keys(&:to_s) }

      # Merge inline Attestations from config file and `include file` with precedence to inline definitions.
      attestations = (plugin_config['attestations'] || []) + attestations 
      attestations.uniq! {|e| e['control_id'] }

      # Remove Attestations records without status provided.
      attestations.reject! { |x| x['status'].eql?("") || x['status'].nil? }

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
