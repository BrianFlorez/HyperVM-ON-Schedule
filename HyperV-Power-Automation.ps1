# VM Name as listed in Hyper-V
$VMName = "Ubuntu Web Server"
# Time window
$StartHour = 6
$EndHour   = 23
# Power Plan GUIDs
$PowerSaverGUID = powercfg /l |
    Where-Object { $_ -match '\(Power Saver\)' } |
    Select-Object -First 1 |
    ForEach-Object {
        ($_ -replace '.*GUID:\s*','' -replace '\s+\(.*','').Trim()
    }    
$UltimateGUID = powercfg /l |
    Where-Object { $_ -match '\(Ultimate Performance\)' } |
    Select-Object -First 1 |
    ForEach-Object {
        ($_ -replace '.*GUID:\s*','' -replace '\s+\(.*','').Trim()
    }
# Game detection (edit as needed)
$GameProcesses = @(
    "steam.exe",
    "steamwebhelper.exe",
    "bf2042.exe"
    #"cod.exe",
    #"valorant.exe",
    #"cs2.exe"
)
# GPU usage threshold (%)
$GpuUsageThreshold = 20
# Functions
function Is-Gaming {
    # Check running game processes
    foreach ($proc in $GameProcesses) {
        if (Get-Process -Name $proc -ErrorAction SilentlyContinue) {
            return $true
        }
    }
    # Check GPU usage
    try {
        $gpu = Get-Counter '\GPU Engine(*)\Utilization Percentage' -ErrorAction Stop
        $usage = ($gpu.CounterSamples | Measure-Object CookedValue -Sum).Sum
        if ($usage -ge $GpuUsageThreshold) {
            return $true
        }
    } catch {}
    return $false
}
function Ensure-VMState {
    $hour = (Get-Date).Hour
    if ($hour -ge $StartHour -and $hour -lt $EndHour) {
        $vm = Get-VM -Name $VMName -ErrorAction SilentlyContinue
        if ($vm.State -ne "Running") {
            Start-VM -Name $VMName
            Write-Host "you aint lost"
        }
    }
    else {
        Write-Host "we here bro"
        Stop-VM -Name $VMName -TurnOff -ErrorAction SilentlyContinue
    }
}
# Main
Ensure-VMState
if (Is-Gaming) {powercfg /setactive $UltimateGUID}
else { powercfg /setactive $PowerSaverGUID }