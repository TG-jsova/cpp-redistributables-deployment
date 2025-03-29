# PowerShell script to automate the deployment of C++ Redistributables 2015-2022 using PowerCLI

# Connect to vCenter
$vCenterServers = @("vcenter1.domain.com", "vcenter2.domain.com") # Replace with your vCenter server FQDNs
foreach ($vCenter in $vCenterServers) {
    Write-Host "Connecting to vCenter: $vCenter"
    Connect-VIServer -Server $vCenter -ErrorAction Stop
}

# Gather a list of Windows Server VMs
$servers = Get-VM | Where-Object { $_.Guest.OSFullName -match "Windows" -and $_.PowerState -eq "PoweredOn" } | Select-Object -ExpandProperty Name

# URLs for the redistributables
$redistributables = @(
    "https://aka.ms/vs/16/release/vc_redist.x86.exe",
    "https://aka.ms/vs/16/release/vc_redist.x64.exe"
)

foreach ($server in $servers) {
    Write-Host "Processing server: $server"

    # Establish a PSSession to the server
    $session = New-PSSession -ComputerName $server -ErrorAction Stop

    foreach ($redistributable in $redistributables) {
        $packageName = Split-Path -Path $redistributable -Leaf
        $installPath = "C:\Temp\$packageName"

        # Download the redistributable to the server
        Invoke-Command -Session $session -ScriptBlock {
            param ($url, $destination)
            Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing
        } -ArgumentList $redistributable, $installPath

        # Check if the redistributable is already installed
        $isInstalled = Invoke-Command -Session $session -ScriptBlock {
            Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%Visual C++ Redistributable%'" | Where-Object { $_.Version -ge "14.0" }
        }

        if (-not $isInstalled) {
            Write-Host "Installing $packageName on $server"
            Invoke-Command -Session $session -ScriptBlock {
                param ($installerPath)
                Start-Process -FilePath $installerPath -ArgumentList "/install /quiet /norestart" -Wait
            } -ArgumentList $installPath

            # Check if a reboot is required
            $rebootPending = Invoke-Command -Session $session -ScriptBlock {
                Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending"
            }

            if ($rebootPending) {
                Write-Host "Reboot required for $server. Rebooting now..."
                Restart-Computer -ComputerName $server -Force -Wait

                # Wait for the server to come back online
                do {
                    Start-Sleep -Seconds 10
                    $isOnline = Test-Connection -ComputerName $server -Count 1 -Quiet
                } until ($isOnline)

                Write-Host "$server is back online."
            }
        } else {
            Write-Host "$packageName is already installed on $server"
        }

        # Clean up the installer
        Invoke-Command -Session $session -ScriptBlock {
            param ($filePath)
            Remove-Item -Path $filePath -Force -ErrorAction SilentlyContinue
        } -ArgumentList $installPath
    }

    # Close the PSSession
    Remove-PSSession -Session $session
}

Write-Host "Deployment completed."

# Disconnect from vCenter
Disconnect-VIServer -Server * -Confirm:$false