[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$requiredFiles = @(
    "Create_AD_User.ps1",
    "Create_New_Client.ps1",
    "Copy_ADGroupMembership_UserToUser.ps1",
    "Copy_ADGroupMembership_GroupToGroup.ps1",
    "3cxTeamsSync.ps1",
    "Offboard_AD_User.ps1",
    "COMPANY_RDS_REQUIRED-TEMPLATE.rdp",
    "New User CSV Files\usersTEMPLATE.csv",
    "New Client CSV Files\TEMPLATE_newClient.csv",
    "config.example.json"
)

$requiredModules = @(
    "ActiveDirectory",
    "ExchangeOnlineManagement",
    "MicrosoftTeams",
    "Az.Resources",
    "PnP.PowerShell"
)

$requiredUserHeaders = @(
    "First Name",
    "Last Name",
    "Domain after @ symbol",
    "Job Title",
    "Telephone DID (ex 4445556666)",
    "Telephone Mobile (ex 4445556666)",
    "Extension",
    "Password"
)

$requiredClientHeaders = @(
    "name",
    "path",
    "displayName",
    "alias",
    "members_commaDelimited"
)

function Test-CsvHeaders {
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string[]]$RequiredHeaders
    )

    $headers = (Get-Content -Path $Path -TotalCount 1) -split ","
    $missingHeaders = $RequiredHeaders | Where-Object { $headers -notcontains $_ }

    if ($missingHeaders) {
        Write-Warning "$Path is missing required headers: $($missingHeaders -join ', ')"
        return $false
    }

    Write-Host "OK: CSV headers found in $Path"
    return $true
}

$hasFailure = $false

Write-Output "Checking required project files..."
foreach ($file in $requiredFiles) {
    if (Test-Path -Path $file) {
        Write-Output "OK: $file"
    }
    else {
        Write-Warning "Missing: $file"
        $hasFailure = $true
    }
}

Write-Output "`nChecking CSV templates..."
if (-not (Test-CsvHeaders -Path "New User CSV Files\usersTEMPLATE.csv" -RequiredHeaders $requiredUserHeaders)) {
    $hasFailure = $true
}
if (-not (Test-CsvHeaders -Path "New Client CSV Files\TEMPLATE_newClient.csv" -RequiredHeaders $requiredClientHeaders)) {
    $hasFailure = $true
}

Write-Output "`nChecking PowerShell modules..."
foreach ($module in $requiredModules) {
    if (Get-Module -ListAvailable -Name $module) {
        Write-Output "OK: $module"
    }
    else {
        Write-Warning "Module not found: $module"
    }
}

Write-Output "`nValidation complete."
if ($hasFailure) {
    exit 1
}
