# C++ Redistributables and VMware Tools Deployment

This Ansible playbook automates the deployment of Microsoft Visual C++ Redistributables and VMware Tools to Windows virtual machines. It dynamically retrieves the inventory of powered-on Windows Server VMs from vCenter, ensures that both x86 and x64 versions of the redistributables are installed, installs VMware Tools, handles reboots if necessary, and cleans up temporary installer files.

## Prerequisites

1. **Docker**: Ensure Docker and Docker Compose are installed on your control machine.
2. **Windows VMs**: The target machines must be running Windows and accessible via PowerShell Remoting (PSRP).
3. **vCenter Access**: Ensure you have access to a vCenter server with the required credentials.
4. **Inventory File**: The playbook dynamically retrieves the inventory of powered-on Windows Server VMs from vCenter, so no static inventory file is required.

## Usage

### Using Docker

1. Clone this repository:
   ```bash
   git clone https://github.com/TG-jsova/vmware-tools-12.5.1-update.git
   cd vmware-tools-12.5.1-update
   ```

2. Set your Windows credentials and vCenter hostname in the playbook:
   Open `deploy_redistributables.yml` and update the following lines:
   ```yaml
   windows_username: '' # Enter your Windows username here
   windows_password: '' # Enter your Windows password here
   vcenter_hostname: "vcenter.example.com" # Replace with your vCenter hostname
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

2. Set your Windows credentials and vCenter hostname in the playbook:
   Open `deploy_redistributables.yml` and update the following lines:
   ```yaml
   windows_username: '' # Enter your Windows username here
   windows_password: '' # Enter your Windows password here
   vcenter_hostname: "vcenter.example.com" # Replace with your vCenter hostname
   ```

3. Run the playbook:
   ```bash
   ansible-playbook deploy_redistributables.yml
   ```

4. Verify the installation:
   - Check the target machines to confirm that the redistributables and VMware Tools are installed.

## Playbook Overview

- **Dynamic Inventory**:
  - Logs in to vCenter using the provided credentials.
  - Retrieves the inventory of powered-on Windows Server VMs.
  - Dynamically creates an in-memory host group for the playbook.
- **Install C++ Redistributables**:
  - Ensures the `C:\Temp` directory exists.
  - Downloads the x86 and x64 redistributable installers.
  - Installs the redistributables.
  - Reboots the machine if required.
  - Cleans up temporary installer files.
- **Install VMware Tools 12.5.1**:
  - Downloads the VMware Tools installer.
  - Installs VMware Tools with reboot suppressed.
  - Reboots the machine if required after installation.
  - Cleans up the VMware Tools installer file.

## Notes

- The playbook uses `community.vmware.vmware_vm_info` to retrieve the vCenter inventory and `win_get_url` to download the redistributables and VMware Tools.
- Rebooting is handled automatically if required by the installation process.
- Ensure that PowerShell Remoting is enabled on the target machines.
- Ensure the `community.vmware` collection and `pyvmomi` Python library are installed:
  ```bash
  ansible-galaxy collection install community.vmware
  pip install pyvmomi
  ```

