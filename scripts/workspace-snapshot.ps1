[CmdletBinding()]
param(
    [string]$Root = (Get-Location).Path
)

function Show-Section {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title
    )

    Write-Host ""
    Write-Host "=== $Title ===" -ForegroundColor Cyan
}

function Show-CommandVersion {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [string]$VersionArgs = "--version"
    )

    if (Get-Command $Command -ErrorAction SilentlyContinue) {
        try {
            $argsList = @()
            if ($VersionArgs) {
                $argsList = $VersionArgs -split " "
            }

            $output = & $Command @argsList 2>$null
            if ($output) {
                $output | Select-Object -First 1
            }
            else {
                Write-Host "$Command is installed but did not return version text."
            }
        }
        catch {
            Write-Host "$Command is installed but the version command failed."
        }
    }
    else {
        Write-Host "$Command not found"
    }
}

Show-Section -Title "Workspace"
Resolve-Path $Root | Select-Object -ExpandProperty Path

Show-Section -Title "Top-Level Files"
Get-ChildItem -LiteralPath $Root -Force |
    Sort-Object Name |
    ForEach-Object {
        $length = if ($_.PSIsContainer) { "-" } else { [string]$_.Length }
        "{0,-6} {1,10} {2:yyyy-MM-dd HH:mm:ss} {3}" -f $_.Mode, $length, $_.LastWriteTime, $_.Name
    }

Show-Section -Title "Tool Versions"
Show-CommandVersion -Command "git"
Show-CommandVersion -Command "gh"
Show-CommandVersion -Command "rg"
Show-CommandVersion -Command "python"
Show-CommandVersion -Command "node"

$gitPath = Join-Path $Root ".git"
if (Test-Path $gitPath) {
    Show-Section -Title "Git Status"
    try {
        git -C $Root status --short
    }
    catch {
        Write-Host "git status failed."
    }
}
else {
    Show-Section -Title "Git Status"
    Write-Host "No .git directory found under the workspace root."
}
