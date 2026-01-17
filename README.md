**HYPERVM-ON-SCHEDULE** is a PowerShell automation tool that ensures your Hyper-V virtual machine runs on a defined schedule and dynamically adjusts your host's power plan.  
**Key Features:**
- Automatically **starts and stops a Hyper-V VM** based on a daily time window (e.g., 6:00 AM to 11:00 PM).  
- Switches your **Power Plan** to **Power Saver** for energy efficiency when idle.  
- Detects gaming activity or high GPU usage and switches to **Ultimate Performance** for optimal performance.  
- Lightweight, easy to configure, and extendable for multiple VMs or gaming processes.
Ideal for developers, sysadmins, and home lab enthusiasts who want to **balance performance and energy efficiency**.


Step 1. Create the following powershell script in this location C:\Scripts\HyperV-Power-Automation.ps1
Step 2. Automate with Task Scheduler to run the script from desired schedule.
  Program: powershell.exe
  Arguments:  -ExecutionPolicy Bypass "-FileC:\Scripts\HyperV-Power-Automation.ps1"
