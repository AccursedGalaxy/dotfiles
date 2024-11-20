<#
 _____     _   _            _____         _        _____ _       _ _ 
| __  |___| |_|_|___ ___   |     |___ ___|_|___   |   __| |_ ___| | |
|    -| . | . | |   |_ -|  | | | | .'| . | |  _|  |__   |   | -_| | |
|__|__|___|___|_|_|_|___|  |_|_|_|__,|_  |_|___|  |_____|_|_|___|_|_|
                                    |___|                           

🚀 Journey into the Cosmos of Robin's PowerShell Universe! 🌌

💻 Author: Robin Bohrer
📚 Version: 1.2.0
📅 Last Updated: 2025-05-03

📜 This is not just a PowerShell profile, it's a chronicle of my journey through the cosmos of code.
It's a living, breathing entity, evolving with every command, every script, every line of code I write.

🧩 Dependencies: The gears and cogs that make this universe turn
- oh-my-posh: The stylist of the terminal, making every command a visual treat
- Terminal-Icons: Because every file deserves to be unique
- komorebi: Because auto tiling is a must. It's like magic, but with windows and stuff
- Chocolatey: The package manager, the courier of the terminal
- nvim: Because editing text is an art
- code: The trusty old VS Code, a coder's best friend
- git: The time machine, enabling me to traverse the streams of time

#>

############################
# Oh-My-Posh Configuration #
############################
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/bubblesextra.omp.json' | Invoke-Expression



################################
# Terminal-Icons Configuration #
################################
Import-Module -Name Terminal-Icons

Add-TiPSImportToPowerShellProfile
Set-TiPSConfiguration -AutomaticallyUpdateModule Weekly
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip EverySession

###############
#  NVIM VARS  #
###############
$env:VISUAL = 'nvim'
$env:EDITOR = 'nvim'


################
#  Chocolatey  #
################
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


##################
#    Komorebi    #
##################
# Check if komorebic is running
try {
    $komorebic = Get-Process komorebi -ErrorAction Stop
} catch {
    # If the process is not found, start it
    Start-Process -FilePath "komorebic" -ArgumentList "start -c `"$Env:USERPROFILE\komorebi.json`" --whkd"
}

###############################
#   Predictive Intellisense   #
###############################
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

############
# PSDecode #
############
Import-Module -Name PSDecode


#################
#  Set aliases  #
#################
Set-Alias -Name n -Value 'nvim'
Set-Alias -Name c -Value 'code'
Set-Alias -Name g -Value 'git'
Set-Alias -Name l -Value 'ls'
Set-Alias -Name ll -Value 'ls -la'
Set-Alias -Name mkdir -Value 'mkdir -p'
Set-Alias -Name sudo -Value 'sudo '


################
#     FZF     #
################
# Import fzf shell extensions for PowerShell
if (Test-Path ~/.fzf.ps1) {
  . ~/.fzf.ps1
}

# Set up an alias for fzf file search
function FzfFindFile {
  $file = fzf --preview 'cat {}'
  if ($file) {
    nvim $file
  }
}
Set-Alias -Name f -Value FzfFindFile

# Set up an alias for fzf directory search
function FzfFindDirectory {
  $dir = fzf --preview 'ls {}'
  if ($dir) {
    Set-Location -Path $dir
  }
}
Set-Alias -Name fd -Value FzfFindDirectory

# Set up an alias for fzf command history search
function FzfFindHistory {
  $history = history | fzf | foreach { $_.CommandLine }
  if ($history) {
    Invoke-Expression $history
  }
}
Set-Alias -Name fh -Value FzfFindHistory

############################
# Set up custom functions  #
############################
# Locate Command Definitions
function which($name) {
  try {
    $command = Get-Command $name -ErrorAction Stop
    $command | Select-Object -ExpandProperty Definition
  } catch {
    Write-Output "Command '$name' not found."
  }
}

function whichdir($name) {
  $command = Get-Command $name
  if ($command.CommandType -eq 'Application') {
    $directory = Split-Path -Parent $command.Definition
    return $directory
  } else {
    Write-Output "$name is not an application, so it doesn't have a directory."
  }
}


# Function to open Event Viewer
function OpenEventViewer {
    eventvwr.msc
}
Set-Alias -Name eventviewer -Value OpenEventViewer

# Function to open Services
function OpenServices {
    services.msc
}
Set-Alias -Name services -Value OpenServices

# Function to open Device Manager
function OpenDeviceManager {
    devmgmt.msc
}
Set-Alias -Name devicemanager -Value OpenDeviceManager

# Function to open Disk Management
function OpenDiskManagement {
    diskmgmt.msc
}
Set-Alias -Name diskmanagement -Value OpenDiskManagement

# Function to open Network Connections
function OpenNetworkConnections {
    ncpa.cpl
}
Set-Alias -Name netconnections -Value OpenNetworkConnections

# Function to open System Properties
function OpenSystemProperties {
    sysdm.cpl
}
Set-Alias -Name sysproperties -Value OpenSystemProperties

# Custom Function To Reload The Shell with "reload" Command
function Reload-Profile {
    . $PROFILE
}
Set-Alias -Name reload -Value Reload-Profile
