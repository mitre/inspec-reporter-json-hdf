#!/bin/bash

JSON_STRING='
{
  "version": "1.2",
  "plugins": {
    "inspec-reporter-json-hdf": {
      "attestations": [
        {
          "control_id": "test-control-1",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "annually",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-2",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "semiannually",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-3",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "quarterly",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-4",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "monthly",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-5",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "every2weeks",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-6",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "weekly",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-7",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "every3days",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-8",
          "status": "passed",
          "updated": "'"$(date -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "daily",
          "explanation": "Non-expired Status passed"
        },
        {
          "control_id": "test-control-9",
          "status": "passed",
          "updated": "'"$(date -d "-13140:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "annually",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-10",
          "status": "passed",
          "updated": "'"$(date -d "-6570:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "semiannually",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-11",
          "status": "passed",
          "updated": "'"$(date -d "-4380:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "quarterly",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-12",
          "status": "passed",
          "updated": "'"$(date -d "-1095:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "monthly",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-13",
          "status": "passed",
          "updated": "'"$(date -d "-504:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "every2weeks",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-14",
          "status": "passed",
          "updated": "'"$(date -d "-252:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "weekly",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-15",
          "status": "passed",
          "updated": "'"$(date -d "-96:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "every3days",
          "explanation": "Expired Status passed"
        },
        {
          "control_id": "test-control-16",
          "status": "passed",
          "updated": "'"$(date -d "-25:00:00"  -I)"'",
          "updated_by": "John Doe, ISSO",
          "frequency": "daily",
          "explanation": "Expired Status passed"
        }
      ]
    }
  }
}
'

echo $JSON_STRING > attestations.json
