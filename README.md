# C++ Redistributables Deployment

This project automates the deployment of the C++ Redistributables 2015-2022 for both 32-bit and 64-bit packages across a fleet of Windows servers.

## Overview

The deployment process is handled by a PowerShell script that reads a list of server addresses from a configuration file, checks for existing installations of the redistributables, and installs the necessary packages on each server.

## Prerequisites

- PowerShell must be installed on the machine executing the script.
- Administrative privileges are required to install software on the target servers.
- Ensure that the target servers are accessible over the network.

## Workspace Structure

The repository is organized as follows:

```
cpp-redistributables-deployment/
├── configs/
│   └── servers-list.txt       # List of target servers for deployment
├── logs/                      # Directory for deployment logs
├── scripts/
│   └── deploy-redistributables.ps1 # PowerShell script for deployment
├── docker-compose.yml         # Docker Compose file for running the workspace
└── README.md                  # Project documentation
```

## Usage

1. **Configure the Server List**: 
   Edit the `configs/servers-list.txt` file to include the addresses or hostnames of the servers where the redistributables need to be deployed. Each entry should be on a new line.

2. **Run the Deployment Script**: 
   Execute the `scripts/deploy-redistributables.ps1` PowerShell script. This script will:
   - Read the server list from `configs/servers-list.txt`.
   - Check for existing installations of the C++ Redistributables.
   - Install the required redistributables if they are not already installed.

3. **Run Using Docker**:
   If you prefer to run the deployment in a containerized environment:
   - Ensure Docker and Docker Compose are installed on your system.
   - Start the container using the following command:
     ```bash
     docker-compose up -d
     ```
   - Access the container's interactive shell:
     ```bash
     docker exec -it cpp-deployment pwsh
     ```
   - From within the container, navigate to `/workspace` and execute the deployment script as described above.

## Logging

Logs of the deployment process will be maintained in the `logs` directory. Ensure that this directory is monitored for any issues during deployment.

## License

This project is licensed under the terms specified in the LICENSE file. Please review it for details on usage and modification rights.