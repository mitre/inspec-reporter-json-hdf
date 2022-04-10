# inspec-reporter-json-hdf

This InSpec Reporter Plugin is developed under the [SAF](https://saf.mitre.org/#/) to extend security testing capabilities for the SAF shared community.

## Installation:

#### if using inspec:
```
"inspec plugin install inspec-reporter-json-hdf" 
```
#### ...or if using cinc-auditor:
```
"cinc-auditor plugin install inspec-reporter-json-hdf" 
```

# Features:

## Manual Attestation
Sometimes requirements (i.e., "InSpec controls") in an InSpec profile require manual review, whereby someone interviews/examines the requirement and confirms (attests as to) whether or not the control requirements have been satisfied. These attestations can be provided to this profile as follow

### Getting Started:

#### Step 1: Simply add your attestations to a json file, such as "my_attestations.json", for example:
```
{
    "plugins": {
        "inspec-reporter-json-hdf": {
            "attestations": [
                {
		"control_id": "2.1",
		"explanation": "Discussed with team to ensure a dedicated machine is running this instance of MySQL.",
		"frequency": "annually",
		"status": "passed",
		"updated": "2022-01-02",
		"updated_by": "Json Smith, Security"
                },
                {
		"control_id": "2.4",
		"explanation": "Discussed with team to ensure that neither default nor shared cryptographic material is not being used.",
		"frequency": "every3days",
		"status": "passed",
		"updated": "2022-04-09",
		"updated_by": "Json Smith, Security"
                },
                {
		"control_id": "9.1",
		"explanation": "Reviewed deployment with team to ensure replication traffic is secured and found some connections non-secure.",
		"frequency": "quarterly",
		"status": "failed",
		"updated": "2022-04-02",
		"updated_by": "Json Smith, Security"
                }
		]
        }
    },
    "version": "1.2"
}
```
#### Step 2: Use the _**HDF**_ reporter _**AND**_ the --config option with attestations file:
```
inspec exec <path to InSpec profile> --reporter hdf:<path/results_filename>.json --config <path/attestations_filename>.json
```
for example:
```
inspec exec https://github.com/mitre/oracle-mysql-ee-5.7-cis-baseline/archive/master.tar.gz --reporter hdf:my_results_with_attestations.json --config my_attestations.json
```
#### Before and after attestation:
![image](https://user-images.githubusercontent.com/34140975/162635932-2ae58e7e-4616-4a7e-8ecf-2ee720ed6006.png)
### Detailed Usage:
#### Attestations JSON template:
```
{
    "plugins": {
        "inspec-reporter-json-hdf": {
            "attestations": [
                {
		"control_id": "<InSpec Control ID>",
		"explanation": "<Attestation text explaining compliance or non-compliance>",
		"frequency": "<How often this review/attestation needs to be updated - Supported frequency choices:  annually, semiannually, quarterly, monthly, every2weeks, weekly, every3days, daily>",
		"status": "<assigned status based on review/attestation - Supported status value choices: passed, failed>",
		"updated": "<last date attestation was performed (in YYYY-MM-DD format) - e.g., 2021-04-12>",
		"updated_by": "<Name, Role of person performing attestation for this control>"
                },
                {
		"control_id": "<Another InSpec Control ID>",
		"explanation": "<Attestation text explaining compliance or non-compliance>",
		"frequency": "<How often this review/attestation needs to be updated - Supported frequency choices:  annually, semiannually, quarterly, monthly, every2weeks, weekly, every3days, daily>",
		"status": "<assigned status based on review/attestation - Supported status value choices: passed, failed>",
		"updated": "<last date attestation was performed (in YYYY-MM-DD format) - e.g., 2021-04-12>",
		"updated_by": "<Name, Role of person performing attestation for this control>"
                }
		]
        }
    },
    "version": "1.2"
}
```

### NOTICE

© 2018-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA 22102-7539, (703) 983-6000.
