<div align="center">
  <h1 align="center"> Azure Storage Backup CLI</h1>
  <p>This script uses Azure CLI to interact with Azure Storage and performs backup by copying blobs from one storage account to another.  </p>
     <img src="https://github.com/ItsTriich/AzureStorageBackup-CLI/blob/e4083c1bf065b84347bd1e2dc9dfbebeb9a02d98/backup.sh%20image.png"/>
     
</div>


## Prerequisites

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
- [Azure Storage Account]
- [SAS Token]

## How to setup

1. Clone the code.
2. Move into the directory.
3. Replace the variables's values like [source_storage_account_name], [source_container_name], [source_sas_token], [destination_storage_account_name], [destination_container_name], [and destination_sas_token] with your actual Azure Storage account and container details.

## How to use

1. [Terminal]  Using the cd command, navigate to the location of backup.sh, then run the script by entering ./backup.sh into the terminal.

## Usage

1. It ensures that the destination storage container exists.
2. It copies all blobs from the source container to the destination container
3. It checks the status of the copy operation and waits until all copies are completed.

## Contributing

Feel free to open up an issue or reach out to me with.

- **Travis Gray**: [Linkedin](https://linkedin.com/in/tg12)

