# Terraform Initial Setup
- Navigate to the terraform-backend directory in this repo
- This directory is responsible for creating backend resources for the terraform env i.e s3 bucket, dynamodb table etc.
- Make sure you configure credentials file in the home directory such that credentials are named as workspace names i.e dev, prod etc
![alt text](/credentials-file-sample.png)
- Follow below mentioned terraform execution steps as they will be same for backend resources creation as well as creating other terraform resources

# Terraform Execution Steps

### Create a terraform workspace.
- Ex. `dev, prod`.

        terraform workspace create <WORKSPACE_NAME>
        

### Initialize terraform
- This will download all the plugins and modules required for execution of terraform code.

        terraform init -backend-config="<WORKSPACE_NAME>.s3.tfbackend"

- **Note** : For creating backend resources we don't need to pass backend-config as the state file for backend resources will be stored in repo it self

        terraform init

### Terraform plan 
- This will give us the idea what resources will be created or updated by terraform.
- Variables will differ for each workspace, so please pass the variables file while executing plan command.

        terraform plan -var-file='<WORKSPACE_NAME>.tfvars'

### Terraform apply 
- This will create or update the resources shown in previous step.
- Variables will differ for each workspace, so please pass the variables file while executing plan command.
        
        terraform apply -var-file='<WORKSPACE_NAME>.tfvars'
        

# Repo Structure

## terraform-infrastructure
- It contains code to create necessary infrastructure required for the applications.
- It will creat necessary netoworking components, database, compute resources as well as container infrastructure required for the applications.
- It utilizes various modules present in `terraform-modules` directory.
- To add new resources in the infrastructure modules from `terraform-modules` can be reused and required configuration can be specified.
- To add new resources other than those present in `terraform-modules` , new module should be created such that it can be reused whenever needed in future.
- To create infra follow the steps given in [terraform execution section](#terraform-execution-steps) or refer the below commands.

        terraform init -backend-config="<WORKSPACE_NAME>.s3.tfbackend"
        terraform plan -var-file='<WORKSPACE_NAME>.tfvars'
        terraform apply -var-file='<WORKSPACE_NAME>.tfvars'

## terrraform-modules
-  This directory contains various modules which are required in our infrastructure.
- This modules are written in such a way that they can be reused to create resources with required infrastructure.
- This module needs to be referenced in appropriate directory with required values for the variables.
- Below is the description of modules present in the `terraform-modules` directory

    - ### network: 
            This module is responsible for creating VPC, subnets, internet gateways, NAT etc in the infrastructure.

    - ### database:
            This module is resposible for creating rds db with secrets rotation in the infrastructure. This module internally uses secret-manager-with-rotation module

    - ### compute:
             This module is responsible for creating certificates for the domains using AWS ACM service and also configuring application load balancer for serving requests. This module internally uses acm-multiple-domains module.

    - ### container:
             This module is responsible for creating all the necessary ecr repos, ecs clusterr required by the application services to run successfully.

    - ### app-services:
            This is the module responsible for creating tasks and services in the ecs cluster depending on the configuration passed to it. This module is used by terraform-applications directory.

## terraform-applications
- This directory is resposible for deploying our services to the ecs cluster.
- For deploying service to the ecs cluster , navigate to the respective service directory and follow the [terraform execution section](#terraform-execution-steps) or refer the below commands

        terraform init -backend-config="<WORKSPACE_NAME>.s3.tfbackend"
        terraform plan -var-file='<WORKSPACE_NAME>.tfvars'
        terraform apply -var-file='<WORKSPACE_NAME>.tfvars'

- If any service needs to be added in future , a directory with service name should be added to this directory using previously created service as a reference.
- Depending on the backend config using during initialization and vars file used during apply , service will be deployed to respective environment/account.
