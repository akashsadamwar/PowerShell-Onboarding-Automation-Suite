# PowerShell Onboarding Automation Suite

PowerShell toolkit for automating common IT onboarding tasks across Active Directory, Microsoft 365, Teams, SharePoint, RDS, and 3CX voice workflows.

> This public version is redacted and uses placeholders such as `COMPANY1.com`, `COMPANYDC`, and `COMPANY_SHAREPOINT_SITE`. Replace those values with your own environment settings before production use.

## What This Project Demonstrates

- Batch employee account creation from CSV
- New client OU, security group, Microsoft 365 group, and Team provisioning
- AD and Microsoft 365 group membership copying
- RDS profile generation from a template
- 3CX and Microsoft Teams voice assignment workflow
- Offboarding support with safe review mode
- Setup, validation, runbook, and troubleshooting documentation

## Project Files

| File | Purpose |
|---|---|
| `Create_AD_User.ps1` | Creates new AD users from a CSV template and applies baseline attributes/groups |
| `Create_New_Client.ps1` | Creates client OUs, AD security groups, M365 groups, and Teams |
| `Copy_ADGroupMembership_UserToUser.ps1` | Copies AD group membership from one user to one or more users |
| `Copy_ADGroupMembership_GroupToGroup.ps1` | Copies AD and Microsoft 365 group membership between groups |
| `3cxTeamsSync.ps1` | Connects a 3CX user to Microsoft Teams Enterprise Voice policies |
| `Offboard_AD_User.ps1` | Disables an AD user, removes group membership, and optionally moves the user to a disabled-users OU |
| `Validate-OnboardingProject.ps1` | Checks local templates, required files, CSV headers, and required PowerShell modules |
| `config.example.json` | Example environment configuration values to replace before production use |
| `docs/SETUP.md` | Workstation and admin prerequisites |
| `docs/RUNBOOK.md` | End-to-end onboarding/offboarding operating procedure |
| `docs/TROUBLESHOOTING.md` | Common failures and fixes |

## New User Workflow

1. Prepare `New User CSV Files/usersTEMPLATE.csv`.
2. Run `Validate-OnboardingProject.ps1` to confirm local templates and modules.
3. Run `Create_AD_User.ps1`.
4. Complete any licensing, Duo, CodeTwo, or 3CX steps that require admin portal confirmation.
5. Run `3cxTeamsSync.ps1` for voice-enabled users.
6. Confirm user login, RDS file, Teams access, SharePoint entry, and ticket closure notes.

## New Client Workflow

1. Prepare `New Client CSV Files/TEMPLATE_newClient.csv`.
2. Confirm target AD path, Microsoft 365 alias, members, and owner.
3. Run `Create_New_Client.ps1`.
4. Confirm AD OU, security group, M365 group, Team, members, and ownership.

## Offboarding Workflow

1. Confirm the offboarding ticket, termination date, asset recovery, and manager approval.
2. Run `Offboard_AD_User.ps1 -SamAccountName username` to review planned actions.
3. Run `Offboard_AD_User.ps1 -SamAccountName username -Execute` only after review.
4. Complete mailbox, license, MFA, device wipe, and ticket documentation steps.

## Required PowerShell Modules

- ActiveDirectory
- ExchangeOnlineManagement
- MicrosoftTeams
- Az.Resources
- PnP.PowerShell

Run:

```powershell
.\Validate-OnboardingProject.ps1
```

## Portfolio Note

This is a realistic IT operations automation project, not a universal plug-and-play product. It is designed to show how onboarding/offboarding tasks can be standardized, documented, validated, and partially automated in a Windows AD and Microsoft 365 environment.
