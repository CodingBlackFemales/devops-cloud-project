# devops-cloud-project
## To create these resources in AWS, install and configure AWSCLI

### Setup AWS & CLI
- Install [AWSCLIv2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Login to AWS Management Console and Generate a new KeyPair. 
- Save the downloaded key
- Configure AWS Command Line Interface (AWS CLI) with a new AWS Access Key and a secret generated on AWS
- Update the ec2_stack.yml and ec2_instance if you're using this template for your application
- Use AWS CLI to run create-stack command that'll create all the resources defined in the ec2_stack.yml


## Cloud Formation
- Folder cloud_formation_template - Creates an EC2 instance and a Security Group, using AWS CloudFormation.
All commands below are to be run from your command line.
### Creating cloud formation stack
- Create stack  ```aws cloudformation create-stack --stack-name App-Node-EC2  --template-body file://$PWD/ec2_stack.yaml```
- Delete stack  ```aws cloudformation delete-stack \    --stack-name App-Node-EC2```
- Update stack  ```aws cloudformation update-stack --stack-name App-Node-EC2 --template-body file://$PWD/ecr.yaml```
## Terraform
- Folder terraform - Creates an EC2 instance and a Security Group, using AWS Terraform.
### Creating resources using terraform
-  Make sure terraform is install and add to your path.
-  Plan infrastruture - ```terraform init && terraform plan```
-  Create infrastruture - ```terraform apply ```
-  Destroy infrastruture - ```terraform destroy```

# Commands
mkdir ~/devops-project
git clone git@github.com:CodingBlackFemales/devops-cloud-project.git
cd devops-cloud-project
### Create new KeyPair on AWS CLI and name it aws-key1 and,
cp ~/Downloads/aws-key1.pem ./
chmod 400 aws-key1.pem

### On AWS CLI, Create a new user with programatic access which will generate a new Access Key & Secret. With that,
aws configure 
### Make sure to use the region name (eu-west-2)

aws cloudformation create-stack  --stack-name App-Node-EC2 --template-body file://$PWD/ec2_stack.yml

### After the stack creation is successful, Get the IP address or DNS of the AppNode EC2 instance
ssh -i aws-key1.pem ubuntu@<IP ADDRESS OR DNS OF THE EC2 INSTANCE>

#### Point your local to EC2 instance,
export DOCKER_HOST=tcp://35.160.122.95:2375
docker ps -a


#### Make sure to delete the stack and all resources when you're done
aws cloudformation delete-stack --stack-name App-Node-EC2 