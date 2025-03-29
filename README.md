# C++ Redistributables Deployment

This project automates the deployment of the C++ Redistributables 2015-2022 for both 32-bit and 64-bit packages across a fleet of Windows servers.

## Overview

The deployment process is handled by a PowerShell script that reads a list of server addresses from a configuration file, checks for existing installations of the redistributables, and installs the necessary packages on each server.

## Prerequisites

- PowerShell must be installed on the machine executing the script.
- Administrative privileges are required to install software on the target servers.
- Ensure that the target servers are accessible over the network.

## Usage

1. **Configure the Server List**: 
   Edit the `configs/servers-list.txt` file to include the addresses or hostnames of the servers where the redistributables need to be deployed. Each entry should be on a new line.

2. **Run the Deployment Script**: 
   Execute the `scripts/deploy-redistributables.ps1` PowerShell script. This script will:
   - Read the server list from `configs/servers-list.txt`.
   - Check for existing installations of the C++ Redistributables.
   - Install the required redistributables if they are not already installed.

## Logging

Logs of the deployment process will be maintained in the `logs` directory. Ensure that this directory is monitored for any issues during deployment.

## License

This project is licensed under the terms specified in the LICENSE file. Please review it for details on usage and modification rights.