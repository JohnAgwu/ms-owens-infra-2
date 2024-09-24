# Terraform Code
This section describes the steps used to create our remote machine from our local machine


## Steps

### Install Terraform (Manual Installation worked faster for me)

### Prerequisites
- Use IAM credentials to set up AWS Authentication
    - export AWS_ACCESS_KEY_ID="your_access_key_id"
    - export AWS_SECRET_ACCESS_KEY="your_secret_access_key"
### Write the Terraform Configuration Code
- Specify required Terraform version and AWS provider version
- Provider configuration
- Create Security Group that allows SSH and HTTP access
- Create EC2 instance
### Initialize Terraform
terraform init

### Plan the Deployment
terraform plan

### Apply the Configuration
terraform apply

### Clean Up Resources
terraform destroy