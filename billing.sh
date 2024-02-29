#!/bin/bash

# Set the service account to impersonate
gcloud config set auth/impersonate_service_account "SERVICE_ACCOUNT_NAME"

# Extract the application name from the command line arguments
appname=$1

# Run the BigQuery stored procedure
bq query "call demo.test_stored_proc('$appname')"
