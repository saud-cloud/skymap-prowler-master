#!/bin/bash
SCAN_REGION=${SCAN_REGION}

echo "S3:             $S3_BUCKET_NAME"
# CleanUp Last Ran Prowler Reports, as they are already stored in S3.
rm -rf output/*

export AWS_ACCESS_KEY_ID=${SCAN_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${SCAN_SECRET_ACCESS_KEY}

accountId=$(aws sts get-caller-identity --output text --query "Account")
START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%S")
echo -e "Assessing AWS Account: $accountId on $(date)"
if [[ $SCAN_REGION == "" ]];
then
    echo "Running the scan on all regions..."
    ./prowler -r $AWS_DEFAULT_REGION -M html,csv,json
else
    echo -e "Region SET. Running the scan against region $SCAN_REGION..."
    ./prowler -r $SCAN_REGION -f $SCAN_REGION -M html,csv,json
fi
COMPLETION_TIME=$(date -u +"%Y-%m-%dT%H:%M:%S")

export AWS_ACCESS_KEY_ID=${ACC_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${ACC_SECRET_ACCESS_KEY}

S3_UPLOAD_HTML_STATUS=$(aws s3 cp output/*.html s3://$S3_BUCKET_NAME/$SCAN_REQUEST_ID/$COMPLETION_TIME.html)
S3_UPLOAD_CSV_STATUS=$(aws s3 cp output/*.csv s3://$S3_BUCKET_NAME/$SCAN_REQUEST_ID/$COMPLETION_TIME.csv)
S3_UPLOAD_JSON_STATUS=$(aws s3 cp output/*.json s3://$S3_BUCKET_NAME/$SCAN_REQUEST_ID/$COMPLETION_TIME.json)

echo "S3_UPLOAD_HTML_STATUS: $S3_UPLOAD_HTML_STATUS"
echo "S3_UPLOAD_CSV_STATUS: $S3_UPLOAD_CSV_STATUS"
echo "S3_UPLOAD_JSON_STATUS: $S3_UPLOAD_JSON_STATUS"

echo "Report stored locally at: prowler/output/ directory"
