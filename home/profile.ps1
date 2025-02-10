# profile.ps1

#==============================================================================#
#               ------- Installation ------                                    #
#==============================================================================#

# Profile can be used for the current user, and all hosts (Console, ISE)
# $profile.AllUsersAllHosts

# Test if profile exists
# Test-Path $PROFILE.CurrentUserAllHosts

# Create profile
# New-Item -Type File -Force $PROFILE.CurrentUserAllHosts

# Edit profile
# ise $profile.AllUsersAllHosts

#==============================================================================#
#               ------- Configuration --------                                 #
#==============================================================================#

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# We don't need these any more; they were just temporary variables to get to $isAdmin.
# Delete them to prevent cluttering up the user profile.
Remove-Variable identity
Remove-Variable principal

# Set up command prompt and window title. Use UNIX-style convention for
# identifying whether user is elevated (root) or not. Window title shows
# current version of PowerShell and appends [ADMIN] if appropriate for easy
# taskbar identification
function prompt
{
    if ($isAdmin)
    {
        "PS [" + (Get-Location) + "] # "
    }
    else
    {
        "PS [" + (Get-Location) + "] $ "
    }
}

$Host.UI.RawUI.WindowTitle = "PowerShell {0}" -f $PSVersionTable.PSVersion.ToString()
if ($isAdmin)
{
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}

#==============================================================================#
#               ------- Aliases --------                                       #
#==============================================================================#
# Basic Linux commands that are working in PowerShell and for which it is not
# necessary to create an alias

# cat, cd, clear, cp, curl
# del, diff
# echo
# h / history
# kill
# ls
# man, mkdir, mv
# ps, pwd
# rm
# set, sleep, sort
# tee, type
# wget
# whoami

New-Alias -Name "alias" -Value Get-Alias -Description "Gets the aliases for the current session" -Option ReadOnly
New-Alias -Name "c" -Value Clear-Host -Description "Clears the display in the host program" -Option ReadOnly
New-Alias -Name "ll" -Value Get-ChildItem -Option ReadOnly
New-Alias -Name "reboot" -Value Restart-Computer -Description "Restarts the operating system on local and remote computers" -Option ReadOnly

#==============================================================================#
#               ------- Functions ------                                       #
#==============================================================================#

# Shortcuts for traversing directories
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# Environment variables
function env { Get-ChildItem Env:* | Sort-Object Name }

# Look for help online directly
function helpO { Get-Help $args -online }
New-Alias -Name "manO" -Value helpO -Option ReadOnly

# Start notepad++
function n { notepad++ $args }

# Open file with its default program
function open { Invoke-Expression $args }

# List all connected users
function who { query user /server:$SERVER }

# Get the location of a program
function which {(Get-Command $args).Path }

# head, tail
function head([int]$n) { Select-Object -first $n }
function tail([int]$n) { Select-Object -last $n }

# Compute file hashes - useful for checking successful downloads
function md5    { Get-FileHash -Algorithm MD5 $args }
function sha1   { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

function watch {
    $interval = 5  # Interval in seconds
    while ($true) {
        Clear-Host
        &$args
        Start-Sleep -Seconds $interval
    }
}

#==============================================================================#
#               ------- Chezmoi ------                                         #
#==============================================================================#
function cma { chezmoi apply }
function cmu { chezmoi update --force }

#==============================================================================#
#               ------- Docker ------                                          #
#==============================================================================#
function dim { docker images }
function dirm { docker image rm $args }
function dl { docker logs -f $args }
function dnls { docker network ls }
function dnrm { docker network rm $args }
function dps { docker ps }
function dpsa { docker ps -a }
function dpsf { docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}" }
function dvls { docker volume ls }
function dvrm { docker volume rm $args }

#==============================================================================#
#               ------- Docker Compose ------                                  #
#==============================================================================#
function dcu { docker-compose up -d }
function dcd { docker-compose down -v }

#==============================================================================#
#               ------- Kubernetes ------                                      #
#==============================================================================#
function kdp { kubectl delete pod $args }
function kex { kubectl exec --stdin --tty $args -- bash }
function kgd { kubectl get deployment }
function kgp { kubectl get pods }
function kgsec { kubectl get secret }
function kgser { kubectl get service }
function kl { kubectl logs -f $args }
function kpf($1, $2) { kubectl port-forward service/${1} ${2}:${2} }
function kro { kubectl rollout restart deployment $args -n default }
function ksl { kubectl get secret $args -o jsonpath='{.data}' }

#==============================================================================#
#               ------- Python ------                                          #
#==============================================================================#

# pip
function pipfr { pip freeze --all > requirements.txt }
function pipir { pip install -r requirements.txt }

# pyenv virtualenvs
function vc {
    $username = $Env:UserName
    python -m virtualenv --python "C:\Users\$username\.pyenv\pyenv-win\versions\3.11.8\python.exe" $args }

#==============================================================================#
#               ------- Visual Studio Code --------                            #
#==============================================================================#
function cwo { code *.code-workspace }
