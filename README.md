# SkyMap-Prowler

## Description

Prowler is a command line tool for AWS Security Best Practices Assessment, Auditing, Hardening and Forensics Readiness Tool.
It follows guidelines of the CIS Amazon Web Services Foundations Benchmark (49 checks) and has 40 additional checks including related to GDPR and HIPAA.
Read more about [CIS Amazon Web Services Foundations Benchmark v1.2.0 - 05-23-2018](https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf)

- Reports are generated in csv, html and json formats but you can update this line in **run-prowler.sh** and generate any output format you want. 
  ```
  ./prowler -M csv,html,json
- Running the docker container will automatically save the scan report to S3 Bucket.

## Features

~140 checks controls covering security best practices across all AWS regions and most of AWS services and related to the next groups:

- Identity and Access Management [group1]
- Logging  [group2]
- Monitoring (14 checks) [group3]
- Networking (4 checks) [group4]
- CIS Level 1 [cislevel1]
- CIS Level 2 [cislevel2]
- Extras (39 checks) *see Extras section* [extras]
- Forensics related group of checks [forensics-ready]
- GDPR [gdpr] Read more [here](#gdpr-checks)
- HIPAA [hipaa] Read more [here](#hipaa-checks)
- Trust Boundaries [trustboundaries] Read more [here](#trustboundaries-checks)

## Usage

- The following environment variables need to be set while running the container:
   - SCAN_ACCESS_KEY_ID `AWS Access Key ID of the account to be scanned`
   - SCAN_SECRET_ACCESS_KEY `AWS Secret Access Key of the account to be scanned`
   - SCAN_REGION **(optional)** `Set this variable only if you want to run region-specific scan`
   - ACC_ACCESS_KEY_ID `AWS Access Key ID of the account where reports will be stored in s3 Bucket`
   - ACC_SECRET_ACCESS_KEY `AWS Secret Access Key of the account where reports will be stored in s3 Bucket`
   - S3_BUCKET_NAME `Name of the bucket where you want to store the scan reports`
