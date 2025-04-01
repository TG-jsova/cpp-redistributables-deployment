# VMware Tools 12.5.1 Update and C++ Redistributables Deployment

This Ansible playbook automates the deployment of Microsoft Visual C++ Redistributables and VMware Tools 12.5.1 on Windows VMs managed through vCenter. It includes several enhancements and fixes to ensure smooth deployment.

## Recent Updates

### Docker Compose Enhancements
- Updated the Docker Compose file to use a custom Debian-based image.
- Added installation of required system packages (`python3`, `python3-pip`, `python3-venv`, `sshpass`, etc.).
- Configured a Python virtual environment for dependency isolation.
- Installed required Python libraries (`ansible`, `pypsrp`, `pyvmomi`, `requests`, `cryptography`) and Ansible collections (`ansible.windows`, `community.windows`, `community.vmware`).

### Gratuitous ARP Fix
- Added a task to apply a gratuitous ARP fix to the Windows registry before the pre-installation reboot.
- The registry key `HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ArpRetryCount` is set to `0` to disable gratuitous ARP.

### Improved Reboot Handling
- Ensured that reboots are conditionally triggered only when necessary, such as after installing or updating redistributables or VMware Tools.

### Optimized Package Checks
- Moved the checks for x86 Redistributable, x64 Redistributable, and VMware Tools to occur after confirming system access, reducing unnecessary reboots.

### Cleanup of Temporary Files
- Added a task to clean up installer files from the `C:\Temp` directory after installation is complete.

## Prerequisites

1. **Docker**: Ensure Docker and Docker Compose are installed on your control machine.
2. **Windows VMs**: The target machines must be running Windows and accessible via PowerShell Remoting (PSRP).
3. **vCenter Access**: Ensure you have access to a vCenter server with the required credentials.
4. **Environment Variables**: Set the following environment variables:
   - `WINDOWS_USERNAME`: Your Windows username.
   - `WINDOWS_PASSWORD`: Your Windows password.
   - `VCENTER_HOSTNAME`: The hostname or IP address of your vCenter server.

## Usage

### Using Docker

1. Clone this repository:
   ```bash
   git clone https://github.com/TG-jsova/vmware-tools-12.5.1-update.git
   cd vmware-tools-12.5.1-update
   ```

2. Set the required environment variables:
   ```bash
   export WINDOWS_USERNAME='your_windows_username'
   export WINDOWS_PASSWORD='your_windows_password'
   export VCENTER_HOSTNAME='your_vcenter_hostname'
   ```

3. Build and run the Docker container:
   ```bash
   docker-compose up --build
   ```

4. Verify the installation:
   - Check the target machines to confirm that the redistributables and VMware Tools are installed.

### Running Locally

1. Clone this repository:
   ```bash
   git clone https://github.com/TG-jsova/vmware-tools-12.5.1-update.git
   cd vmware-tools-12.5.1-update
   ```

2. Set the required environment variables:
   ```bash
   export WINDOWS_USERNAME='your_windows_username'
   export WINDOWS_PASSWORD='your_windows_password'
   export VCENTER_HOSTNAME='your_vcenter_hostname'
   ```

3. Install the required Python dependencies:
   Ensure the following Python libraries are installed in your environment:
   ```bash
   pip install ansible pypsrp pyvmomi requests cryptography
   ```

4. Run the playbook:
   ```bash
   ansible-playbook deploy_redistributables.yml
   ```

5. Verify the installation:
   - Check the target machines to confirm that the redistributables and VMware Tools are installed.

## Features

- **vCenter Inventory Retrieval**: Automatically retrieves the inventory of VMs from vCenter and filters powered-on Windows VMs.
- **C++ Redistributables Installation**: Installs or updates both x86 and x64 versions of Microsoft Visual C++ Redistributables.
- **VMware Tools Installation**: Installs or updates VMware Tools to version 12.5.1.
- **Gratuitous ARP Fix**: Applies a registry fix to address gratuitous ARP issues on Windows servers.
- **Reboot Management**: Handles reboots before and after installations as needed.
- **Optimized Package Checks**: Ensures package checks occur only after confirming system access, reducing unnecessary reboots.
- **Temporary File Cleanup**: Removes installer files after successful deployment.

## Requirements

- Ansible 2.10 or later
- Required Ansible collections:
  - `community.vmware`
  - `ansible.windows`
  - `community.windows`

## Notes

- Ensure that WinRM is properly configured on the target Windows VMs.
- The playbook assumes that the `C:\Temp` directory exists or will be created during execution.

