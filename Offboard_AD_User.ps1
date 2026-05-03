[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory)]
    [string]$SamAccountName,

    [string]$DisabledUsersOu = "OU=Disabled Users,DC=COMPANY,DC=com",

    [switch]$Execute
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Output "[Offboarding] $Message"
}

Write-Step "Loading AD user $SamAccountName"
$user = Get-ADUser -Identity $SamAccountName -Properties MemberOf, DistinguishedName, Description, Enabled

if (-not $Execute) {
    Write-Output ""
    Write-Output "Review mode only. Re-run with -Execute to apply changes."
    Write-Output "Planned actions:"
    Write-Output "- Disable AD account: $SamAccountName"
    Write-Output "- Remove non-primary AD group memberships"
    Write-Output "- Move user to: $DisabledUsersOu"
    Write-Output "- Update description with offboarding timestamp"
    Write-Output ""
}

if ($Execute -and $PSCmdlet.ShouldProcess($SamAccountName, "Disable AD account")) {
    Disable-ADAccount -Identity $user
    Write-Step "Disabled AD account"
}

$groups = @($user.MemberOf)
foreach ($groupDn in $groups) {
    if ($Execute -and $PSCmdlet.ShouldProcess($groupDn, "Remove $SamAccountName from group")) {
        Remove-ADGroupMember -Identity $groupDn -Members $user -Confirm:$false
    }
    else {
        Write-Step "Would remove from group: $groupDn"
    }
}

if ($Execute -and $PSCmdlet.ShouldProcess($SamAccountName, "Move account to disabled-users OU")) {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $DisabledUsersOu
    Write-Step "Moved account to disabled-users OU"
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$description = "Offboarded $timestamp. Previous description: $($user.Description)"
if ($Execute -and $PSCmdlet.ShouldProcess($SamAccountName, "Update AD description")) {
    Set-ADUser -Identity $SamAccountName -Description $description
    Write-Step "Updated AD description"
}

Write-Output ""
Write-Output "Manual follow-up checklist:"
Write-Output "- Recover laptop, charger, badge, mobile device, and peripherals"
Write-Output "- Remove or convert mailbox access according to company policy"
Write-Output "- Remove Microsoft 365 licenses after retention requirements are met"
Write-Output "- Revoke sessions and confirm MFA/device access is disabled"
Write-Output "- Document completion notes in the ticket"
