# C++ Redistributables Deployment

This project automates the deployment of the C++ Redistributables 2015-2022 for both 32-bit and 64-bit packages across a fleet of Windows servers.

## Overview

The deployment process is handled by a PowerShell script that reads a list of server addresses from a configuration file, checks for existing installations of the redistributables, and installs the necessary packages on each server.

## Prerequisites

- PowerShell must be available on the target servers.
- Administrative privileges are required to install the redistributables.
- Ensure that the server addresses are correctly listed in the `configs/servers-list.txt` file.

## Usage

1. **Edit the Server List**: Open `configs/servers-list.txt` and add the addresses or hostnames of the servers where you want to deploy the redistributables. Each entry should be on a new line.

2. **Run the Deployment Script**: Execute the `scripts/deploy-redistributables.ps1` PowerShell script. You can do this by opening PowerShell and running the following command:

   ```powershell
   .\deploy-redistributables.ps1
   ```

3. **Monitor Logs**: Check the logs directory for any output or error logs generated during the deployment process.

## License

This project is licensed under the terms specified in the LICENSE file. Please review it for details on usage and modification rights.