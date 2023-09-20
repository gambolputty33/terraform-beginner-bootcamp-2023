# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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
