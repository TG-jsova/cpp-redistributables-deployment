# C++ Redistributables Deployment

This Ansible playbook automates the deployment of Microsoft Visual C++ Redistributables to Windows virtual machines. It ensures that both x86 and x64 versions of the redistributables are installed, handles reboots if necessary, and cleans up temporary installer files.

## Prerequisites

1. **Ansible**: Ensure Ansible is installed on your control machine.
2. **Windows VMs**: The target machines must be running Windows and accessible via PowerShell Remoting (PSRP).
3. **Inventory File**: Use an inventory file to specify the target hosts and credentials.

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/jasonsova/cpp-redistributables-deployment.git
   cd cpp-redistributables-deployment
   ```

2. Set up your inventory file (e.g., `windows_vms`):
   ```ini
   [windows_vms]
   <IP or hostname>
   ```

3. Run the playbook with the inventory file:
   ```bash
   ansible-playbook -i windows_vms deploy_redistributables.yml
   ```

4. Verify the installation:
   - Check the target machines to confirm that the redistributables are installed.

## Playbook Overview

- **Inventory File**: Specifies the target hosts and credentials.
- **Install C++ Redistributables**:
  - Ensures the `C:\Temp` directory exists.
  - Downloads the x86 and x64 redistributable installers.
  - Installs the redistributables if not already installed.
  - Reboots the machine if required.
  - Cleans up temporary installer files.

## Notes

- The playbook uses `win_get_url` to download the redistributables and `win_package` to install them.
- Rebooting is handled automatically if required by the installation process.
- Ensure that PowerShell Remoting is enabled on the target machines.

## License

This project is licensed under the MIT License.