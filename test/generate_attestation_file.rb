require 'json'
require 'date'
require 'csv'


DATE_FORMAT = '%Y-%m-%d'.freeze

today = DateTime.now.strftime(DATE_FORMAT)

attestations = []

# Non Expired Attestations

attestations << {
                   'control_id' => 'test-control-1',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'annually',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-2',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'semiannually',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => "John Doe, ISSO"
}
attestations << {
                   'control_id' => 'test-control-3',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'quarterly',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-4',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'monthly',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-5',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'every2weeks',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-6',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'weekly',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-7',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'every3days',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-8',
                   'explanation' => 'Non-expired Status passed',
                   'frequency' => 'daily',
                   'status' => 'passed',
                   'updated' => today,
                   'updated_by' => 'John Doe, ISSO'
}

# Expired Attestations
attestations << {
                   'control_id' => 'test-control-9',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'annually',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_year(1.5).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-10',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'semiannually',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_year(0.75).strftime(DATE_FORMAT),
                   'updated_by' => "John Doe, ISSO"
}
attestations << {
                   'control_id' => 'test-control-11',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'quarterly',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_year(0.5).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-12',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'monthly',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_month(2).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-13',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'every2weeks',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_day(15).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-14',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'weekly',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_day(8).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-15',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'every3days',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_day(4).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}
attestations << {
                   'control_id' => 'test-control-16',
                   'explanation' => 'Expired Status passed',
                   'frequency' => 'daily',
                   'status' => 'passed',
                   'updated' => DateTime.now.prev_day(2).strftime(DATE_FORMAT),
                   'updated_by' => 'John Doe, ISSO'
}

config_json = {
  'plugins' => {
    'inspec-reporter-json-hdf' => {
       'include-attestations-file' => {
           'type' => 'csv',
           'path' => './attestations.csv'
       },
      'attestations' => attestations[0..6]
    }
  },
  'version' => '1.2'
}

File.write('attestations.json', config_json.to_json)

CSV.open("attestations.csv", "wb") do |csv|
  csv << ["Control_ID","Explanation","Frequency","Status","Updated","Updated_By"]
  attestations[7..15].each do |hash|
    csv << hash.values
  end
end
