# Terraform Beginner Bootcamp 2023

## Table of Contents

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
- [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
- [Considerations for Linux distributions](#considerations-for-linux-distributions)
- [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
- [Shebang Considerations](#shebang-considerations)
- [Execution Considerations](#execution-considerations)
- [Linux Permissions Considerations](#linux-permissions-considerations)
- [Github Lifecycle (Before, Init, Command)](#github-lifecycle-before-init-command)
- [Working With Environment Variables (Env Vars)](#working-with-environment-variables-env-vars)
- [env command](#env-command)
- [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
- [Printing Env Vars](#printing-env-vars)
- [Scoping of Env Vars](#scoping-of-env-vars)
- [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#persisting-env-vars-in-gitpod)
- [Terraform Basics](#terraform-basics)
- [Terraform Registry](#terraform-registry)
- [Terraform Console](#terraform-console)
- [Terraform Init](#terraform-init)
- [Terraform Plan](#terraform-plan)
- [Terraform Apply](#terraform-apply)
- [Terraform Lock Files](#terraform-lock-files)
- [Terraform State Files](#terraform-state-files)
- [Terraform Destroy](#terraform-destroy)
- [Terraform Directory](#terraform-directory)
- [Terraform Cloud and Gitpod Workspace](#terraform-cloud-and-gitpod-workspace)
- [Terraform GUI issues](#terraform-gui-issues)
- [Root Module Structure](#root-module-structure)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI installation instructions have changed due to GPG keyring changes.  So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux distributions

This project is built against Ubuntu.
Please consider checking your Linux distribution and change accordingly to your distribution needs.

[How To Check the OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
cat /etc/os-release
PRETTY_NAME="Ubuntu 23.04"
NAME="Ubuntu"
VERSION_ID="23.04"
VERSION="23.04 (Lunar Lobster)"
VERSION_CODENAME=lunar
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=lunar
LOGO=ubuntu-logo
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI GPG deprecation issues, we noticed that the Bash script steps were a considerable amount more code, so we decided to create a Bash script to install the Terraform CLI.

This Bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.wml)) tidy.
- This will allow us an easier time to debug and execute manually Terraform CLI install.
- This will allow for better portability for other projects that need to install the Terraform CLI.

### Shebang Considerations
 
A Shebang (pronounced Sha-bang) tells the Bash script what program that will interpret the script. `eg. #!/bin/bash`
 
ChatGPT recommended this format for Bash: `#!/usr/bin/env bash`
 
- for portability with different OS distributions
- will search the user's PATH for the Bash executable

[Shebang in Unix/Linux](https://en.wikipedia.org/wiki/Shebang_(Unix))

### Execution Considerations

When executing the Bash script, we can use the `./` shorthand notation to execute the Bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml, we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

### Linux Permissions Considerations

In order to make our Bash scripts executable we need to change Linux permissions for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

[chmod](https://en.wikipedia.org/wiki/Chmod)

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

[Github Lifecycle](https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle)

### Working With Environment Variables (Env Vars)

### env command

We can list out all Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal, we can set using `export HELLO='world'`

In the terminal, we can unset using `unset HELLO`

We can set an env var temporarily when just using a command:

```sh
HELLO='world' ./bin/print_message
```

Within a Bash script, we can set an env var without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Env Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up new Bash terminals in VSCode, it will not be aware of Env Vars that you have set in another window.

If you want Env Vars to persist across all future Bash terminals that are open, you need to set Env Vars in your Bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist Env Vars into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the Env Vars for all Bash terminals opened in those workspaces.

You can also set Env Vars in the `.gitpod.yml` but this can only contain non-sensitive Env Vars.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it's successful, you should see a JSON payload return that looks like this:

```json
{
    "UserId": "ASDFLKSFDA32412134FDASLKFDSA",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from the IAM user in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry which is located at [Terraform Registry](https://registry.terraform.io/)

- **Providers** are an interface to APIs that will allow you to create cloud resources using Terraform.
- **Modules** are a way to make large amounts of Terraform code modular, portable, and sharable.

### Terraform Console

We can see a list of all of the Terraform commands by simply typing `terraform`

### Terraform Init

At the start of a new Terraform project we will run `terraform init` to download the binaries for the Terraform providers that we'll use in this project.

### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

### Terraform Apply

`terraform apply`
This will run a plan and pass the changeset to be executed by Terraform.  Apply should prompt for a 'yes' or 'no'.

If we want to automatically approve an apply, we can provide the auto approve flag. eg. `terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File should be committed to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your Version Control System (VSC) eg. Github

This file can contain sensitive data. 

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is a file that contains the state of the previous state file.

### Terraform Destroy

`terraform destroy`
This will destroy resources.

You can also use the auto approve flag to skip the approve prompt.
eg. `terraform apply -destroy -auto-approve`

### Terraform Directory

The `.terraform` directory contains binaries of the Terraform providers.

### Terraform Cloud and Gitpod Workspace

When attempting to run `terraform login`, it will launch a WYSIWYG view to generate an API token.  However, it doesn't work as expected in Gitpod VSCODE in the brower.

The workaround is to manually generate an API token in Terraform Cloud:

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

In Terraform Cloud, goto User Settings, Tokens.
Click on the `Create an API Token` icon.
Set the duration of the token to 90 days.
Copy the API token to the clipboard.

In Gitpod, execute these commands:

```
gp env TERRAFORM_CLOUD_TOKEN='DUMMYAPITOKEN'
export TERRAFORM_CLOUD_TOKEN='DUMMYAPITOKEN'
```

Be sure to put your own copied API token where it says `DUMMYAPITOKEN`.

Then create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

The second command string will open the JSON file that just got created.
Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TERRAFORM_CLOUD_TOKEN"
    }
  }
}
```

This Bash script will generate the Terraform API token in the correct directory.  This script gets executed in your Gitpod terminal.  The script gets saved at `./bin/generate_tfrc_credentials`:

```
#!/usr/bin/env bash

# Check if the TERRAFORM_CLOUD_TOKEN environment variable is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
    echo "Error: TERRAFORM_CLOUD_TOKEN environment variable is not set."
    exit 1
fi
  
# Specify the destination directory
credentials_dir="/home/gitpod/.terraform.d/"
credentials_file="${credentials_dir}credentials.tfrc.json"
  
# JSON structure for credentials.tfrc.json
json_structure=$(cat <<-END
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TERRAFORM_CLOUD_TOKEN"
    }
  }
}
END
)

# Create the directory if it doesn't exist
mkdir -p "$credentials_dir"

# Write the JSON structure to credentials.tfrc.json
echo "$json_structure" > "$credentials_file"

echo "credentials.tfrc.json has been created at $credentials_file with the following content:"
cat "$credentials_file"
```

### Terraform GUI issues

This block of code is found in `main.tf`.  The `organization` value is found in the lower left hand corner of your Terraform Cloud GUI window.  Be sure to use the current workspace value.

```
terraform {
  cloud {
    organization = "terraform-beginner-bootcamp3"
    workspaces {
      name = "workspace-name"
    }
  }
``` 

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
|
├── main.tf - Everything else is stored here
├── variables.tf - Stores the structure of input variables
├── terraform.tfvars - The data of variables we want to load into our Terraform project
├── outputs.tf - Stores our output
├── providers.tf - Defined required providers and their configuration
└── README.md - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)