[CmdletBinding()]
param()

$packages = @(
    @{ Id = "Git.Git"; Name = "Git" },
    @{ Id = "GitHub.cli"; Name = "GitHub CLI" },
    @{ Id = "BurntSushi.ripgrep.MSVC"; Name = "ripgrep" },
    @{ Id = "Python.Python.3.12"; Name = "Python 3.12" }
)

function Test-CommandExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

if (-not (Test-CommandExists -Name "winget")) {
    throw "winget is required but was not found in PATH."
}

foreach ($package in $packages) {
    Write-Host "Installing $($package.Name)..." -ForegroundColor Cyan
    winget install --id $package.Id --exact --accept-source-agreements --accept-package-agreements
}

Write-Host ""
Write-Host "Tool install commands were submitted." -ForegroundColor Green
Write-Host "You may need to open a new shell before the new commands appear in PATH." -ForegroundColor Yellow
