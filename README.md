# CS 312 Final Project

## Fully Automated AWS Minecraft Server -- Braylon Steffen

This is a tutorial about running a program that will provision and configure an AWS EC2 Ubuntu instance and download and run a Minecraft server on it.
We will use a tool called Terraform. Terraform will provision the AWS instance, load the necessary files into it, and call a bash script that will run 
the Minecraft server.

### Program Flow

Terraform ────────► Bash Script ────────► systemd ────────► Minecraft server
    │
    │
    └─────────────►  Server IP

### Install terraform

1. On your computer, click [this link](https://developer.hashicorp.com/terraform/downloads) to open Terraform's installation window.
2. Select your operating system.
3. Once you have selected the tab for your operating system, click Download on the binary download corresponding to your computer's specifications.
4. Once the file has downloaded, open the zip file and run the binary executable inside called `terraform.exe`.

### Set up AWS credentials

1. It is assumed you have access to an AWS account with credentials. Find `~/.aws/credentials` on your machine if you are on MacOS or Linux, or `C:\Users\USERNAME\.aws\credentials` on Windows (make sure to replace USERNAME with your windows username).
2. If the folder and/or file does not exist, create it, and then copy/paste your AWS CLI credentials into the credentials file.

### Navigate to the repo folder

1. Clone this repo to a folder on your computer.
2. Open a command line terminal and navigate to the repo folder. Within it should be the contents of this repo.

### Set up private key

1. It is assumed you have or can create a key pair in AWS called `MCServer` and save the private key file, `MCServer.pem`.
2. Create a folder within the repo folder called `secrets`. Store `MCServer.pem` into the `secrets` folder.

### Run Terraform

1. Navigate to the `terraform` folder in the terminal.
2. Run `terraform init`. This will initialize terraform in this directory.
3. Run `terraform apply`. This will begin the provisioning and configuation of an EC2 instance on your account. You will need to type 'yes' to confirm the provisioning that Terraform will apply.
4. After a moment, the EC2 instance will have been provisioned and started! Take note of the IP address shown in the command line output at the end.

### Connect to Minecraft Server

All that's left is to wait a few minutes while the server installs packages and starts up the server. During this time, you can do the following:

1. Open your Minecraft: Java Edition client.
2. Click on `Multiplayer`
3. Click on `Direct Connect` or `Add Server`.
4. In the `Server Address` box, paste the IP address you took note of previously. Once it has been pasted, type `:25565` following the IP address. It should be similar to `x.x.x.x:25565`, where `x` is a 1-3 digit number.
5. Click `Done` or `Join Server` (depending on what you clicked in step 3) and you should load into the server momentarily!
    - If there is an error, try again in 1 minute. Sometimes it takes a while for the server to start accepting connections.
