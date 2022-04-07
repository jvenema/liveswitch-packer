# Configure

### Set environment variables
Create a variables.json in the root. Add your digitalocean token or Azure credentials to it like this:

```json
{
    "digitalocean_token":"dop_v1_xxxxx",
    "azure_client_id":"xxx",
    "azure_tenant_id":"xxx",
    "azure_subscription_id":"xxx",
    "azure_client_secret":"xxx"
}
```

### Add the docker compose files (and systemd configuration)
`git clone https://github.com/jvenema/liveswitch-docker-compose.git`


### Install packer
Go to packer.io for details on this one.

# Validate the configuration
`packer validate -var-file=variables.json template.json`

# Build a new image
`packer build -var-file=variables.json template.json`

# Misc notes

### DigitalOcean
Log in under your "team" account when you create your token so the image shows in your team account for publishing.

### Azure
Guide: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer

Setup (this uses the az command line to keep all this in a simple script here):
First, you have to create a resource group and use the resource group name in your config (this is the default)
`az group create -n PackerLiveSwitchGroup -l eastus`

Second, you need to create the account that will be used to create the image:
`az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<subscription_id> --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"`

PS, if you are unsure of your subscription id:
`az account show --query "{ subscription_id: id }"`

One-liner of the above that creates the account based on your current subscription:
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/$(az account show --query "id" -o tsv) --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

Copy/paste the output into the variables.json file as noted above.

#### Other helpful tips
To find a list of servers on Azure you can use the Azure command line tool: `az vm image list --output table`
To find a list of server sizes on Azure you can use the Azure command line tool: `az vm list-sizes --location eastus --output table`
To find a list of server sizes available in a given region: `az vm list-skus --location eastus --size Standard_D --all --output table`


az ad sp create-for-rbac --role Contributor --scopes /subscriptions/$(az account show --query "{ subscription_id: id }") --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"