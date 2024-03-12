#!/bin/bash

# Source storage account details
SOURCE_STORAGE_ACCOUNT_NAME="source_storage_account_name"
SOURCE_STORAGE_CONTAINER_NAME="source_container_name"
SOURCE_STORAGE_SAS_TOKEN="source_sas_token"

# Destination storage account details
DEST_STORAGE_ACCOUNT_NAME="destination_storage_account_name"
DEST_STORAGE_CONTAINER_NAME="destination_container_name"
DEST_STORAGE_SAS_TOKEN="destination_sas_token"

# Install Azure CLI and Login into Azure

setup() {
    # Install az cli
    curl -sL https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
    # Login
    az login 
    echo "You're logged in."
    
}

# Function to perform backup

perform_backup() {
    # Ensure source and destination containers exist
    az storage container create --name "$DEST_STORAGE_CONTAINER_NAME" --account-name "$DEST_STORAGE_ACCOUNT_NAME" --sas-token "$DEST_STORAGE_SAS_TOKEN" --output none
    
    # Copy blobs from source container to destination container
    az storage blob copy start-batch --destination-container "$DEST_STORAGE_CONTAINER_NAME" --account-name "$DEST_STORAGE_ACCOUNT_NAME" --source-container "$SOURCE_STORAGE_CONTAINER_NAME" --source-account-name "$SOURCE_STORAGE_ACCOUNT_NAME" --source-sas "$SOURCE_STORAGE_SAS_TOKEN" --pattern '*' --output none
    
    # Check copy status
    copy_status=$(az storage blob copy show --account-name "$DEST_STORAGE_ACCOUNT_NAME" --container-name "$DEST_STORAGE_CONTAINER_NAME" --sas-token "$DEST_STORAGE_SAS_TOKEN" --query "[?status=='pending'].name" --output tsv)
    
    # Wait for copy operations to complete
    while [ ! -z "$copy_status" ]; do
        echo "Waiting for copy operations to complete..."
        sleep 10
        copy_status=$(az storage blob copy show --account-name "$DEST_STORAGE_ACCOUNT_NAME" --container-name "$DEST_STORAGE_CONTAINER_NAME" --sas-token "$DEST_STORAGE_SAS_TOKEN" --query "[?status=='pending'].name" --output tsv)
    done
    
    echo "Backup completed successfully."
}

# Main script execution
perform_backup

