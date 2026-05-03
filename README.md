# PowerShell Onboarding Automation Suite

An IT operations automation toolkit for standardizing employee onboarding, client setup, access copying, offboarding, and Microsoft 365/Teams support workflows.

This project is built around real Level 1 and Level 2 IT support tasks: Active Directory account creation, Microsoft 365 group setup, Teams provisioning, SharePoint tracking, RDS profile generation, and 3CX voice coordination.

> Public repository note: environment-specific values have been redacted. Replace placeholders such as `COMPANY1.com`, `COMPANYDC`, `ADMINUSER@COMPANY.com`, and SharePoint URLs before using this in a live environment.

## At A Glance

| Area | Coverage |
|---|---|
| User onboarding | CSV-based AD user creation, attributes, groups, RDS file generation, SharePoint tracking |
| Client onboarding | AD OU creation, security group creation, Microsoft 365 group and Team provisioning |
| Access management | Copy AD user membership and copy AD/M365 group membership |
| Voice workflow | 3CX to Microsoft Teams Enterprise Voice policy assignment |
| Offboarding | Safe review mode, account disablement, group removal, OU move, follow-up checklist |
| Validation | File checks, CSV header checks, required module review |
| Documentation | Setup guide, runbook, and troubleshooting guide |

## Why This Project Matters

Manual onboarding creates repeated work, inconsistent access, missed steps, and slow ticket resolution. This project turns common support workflows into repeatable scripts and documented procedures so IT teams can:

- Reduce repetitive account setup work
- Standardize onboarding and offboarding steps
- Improve ticket documentation and handoff quality
- Lower the chance of missed access, group, or license tasks
- Give Level 1 support a clear operating runbook

## Tech Stack

| Technology | Used For |
|---|---|
| PowerShell | Automation and admin workflows |
| Active Directory | User accounts, OUs, security groups, access management |
| Microsoft 365 | Groups, licensing handoff, Exchange/Teams coordination |
| Microsoft Teams | Team creation and voice policy workflow |
| SharePoint / PnP.PowerShell | Employee tracker list updates and RDS attachment handling |
| RDS | Remote Desktop profile template generation |
| 3CX | VoIP and Teams Enterprise Voice coordination |

## Repository Structure

```text
.
|-- 3cxTeamsSync.ps1
|-- Copy_ADGroupMembership_GroupToGroup.ps1
|-- Copy_ADGroupMembership_UserToUser.ps1
|-- Create_AD_User.ps1
|-- Create_New_Client.ps1
|-- Offboard_AD_User.ps1
|-- Validate-OnboardingProject.ps1
|-- COMPANY_RDS_REQUIRED-TEMPLATE.rdp
|-- config.example.json
|-- New Client CSV Files/
|   |-- TEMPLATE_newClient.csv
|   |-- test3.csv
|-- New User CSV Files/
|   |-- usersTEMPLATE.csv
|-- docs/
|   |-- RUNBOOK.md
|   |-- SETUP.md
|   |-- TROUBLESHOOTING.md
```

## Scripts

| Script | What It Does | Typical Use |
|---|---|---|
| `Create_AD_User.ps1` | Creates new AD users from CSV, applies attributes/groups, generates RDS files, and updates SharePoint tracking | New employee onboarding |
| `Create_New_Client.ps1` | Creates client OUs, AD security groups, Microsoft 365 groups, and Teams | New client setup |
| `Copy_ADGroupMembership_UserToUser.ps1` | Copies group membership from one user to one or more target users | Matching access for similar roles |
| `Copy_ADGroupMembership_GroupToGroup.ps1` | Copies AD and Microsoft 365 group membership between groups | Client/team access migration |
| `3cxTeamsSync.ps1` | Assigns Teams voice settings for a 3CX-enabled user | Phone and Teams calling setup |
| `Offboard_AD_User.ps1` | Reviews and applies AD offboarding actions | Employee termination workflow |
| `Validate-OnboardingProject.ps1` | Checks project files, CSV headers, and PowerShell module availability | Pre-flight validation |

## Quick Start

1. Clone the repository.

```powershell
git clone https://github.com/akashsadamwar/PowerShell-Onboarding-Automation-Suite.git
cd PowerShell-Onboarding-Automation-Suite
```

2. Review setup requirements.

```powershell
notepad .\docs\SETUP.md
```

3. Run the validator.

```powershell
powershell -ExecutionPolicy Bypass -File .\Validate-OnboardingProject.ps1
```

4. Prepare the required CSV template.

```text
New User CSV Files/usersTEMPLATE.csv
New Client CSV Files/TEMPLATE_newClient.csv
```

5. Run the workflow script for the task.

```powershell
.\Create_AD_User.ps1
.\Create_New_Client.ps1
.\Offboard_AD_User.ps1 -SamAccountName username
```

## Workflow Map

### Employee Onboarding

| Step | Action | Tool |
|---|---|---|
| 1 | Review ticket, role, department, manager, device, phone, and access requirements | Ticketing system |
| 2 | Complete new user CSV template | `usersTEMPLATE.csv` |
| 3 | Validate local files and modules | `Validate-OnboardingProject.ps1` |
| 4 | Create AD user, attributes, baseline groups, RDS file, and SharePoint entry | `Create_AD_User.ps1` |
| 5 | Assign licenses and complete portal-only steps | M365 admin center |
| 6 | Configure Teams voice if required | `3cxTeamsSync.ps1` |
| 7 | Confirm login, Teams, RDS, SharePoint, and ticket notes | Support checklist |

### Client Onboarding

| Step | Action | Tool |
|---|---|---|
| 1 | Confirm client name, AD path, group name, alias, owner, and members | Ticket/request |
| 2 | Complete client CSV template | `TEMPLATE_newClient.csv` |
| 3 | Validate local files and modules | `Validate-OnboardingProject.ps1` |
| 4 | Create AD OU, security group, M365 group, and Team | `Create_New_Client.ps1` |
| 5 | Confirm ownership and access | M365/Teams admin review |

### Employee Offboarding

| Step | Action | Tool |
|---|---|---|
| 1 | Confirm termination request, manager approval, retention needs, and device recovery | Ticketing system |
| 2 | Review planned AD changes | `Offboard_AD_User.ps1 -SamAccountName username` |
| 3 | Apply AD disablement, group removal, OU move, and description update | `Offboard_AD_User.ps1 -SamAccountName username -Execute` |
| 4 | Remove licenses, revoke sessions, handle mailbox, and document assets | Admin portals and ticket notes |

## Required PowerShell Modules

```powershell
Install-Module ExchangeOnlineManagement
Install-Module MicrosoftTeams
Install-Module Az.Resources
Install-Module PnP.PowerShell
```

The `ActiveDirectory` module is installed through RSAT on Windows admin workstations.

## Configuration

Use `config.example.json` as a reference for environment-specific values:

```json
{
  "activeDirectory": {
    "templateUser": "nstaff",
    "disabledUsersOu": "OU=Disabled Users,DC=COMPANY,DC=com"
  },
  "microsoft365": {
    "sharePointSiteUrl": "https://COMPANY.sharepoint.com/sites/COMPANY-SPECIFIC-URL/",
    "employeeTrackerList": "Employee Tracker"
  }
}
```

Do not commit real tenant details, internal server names, admin accounts, or production credentials to a public repository.

## Documentation

| Document | Purpose |
|---|---|
| `docs/SETUP.md` | Admin workstation setup, modules, and environment preparation |
| `docs/RUNBOOK.md` | End-to-end onboarding, client setup, access copy, and offboarding workflow |
| `docs/TROUBLESHOOTING.md` | Common issues and fixes |

## Validation Example

Expected validation output on a non-admin workstation may show missing module warnings:

```text
Checking required project files...
OK: Create_AD_User.ps1
OK: Create_New_Client.ps1
OK: Offboard_AD_User.ps1

Checking CSV templates...
OK: CSV headers found in New User CSV Files\usersTEMPLATE.csv
OK: CSV headers found in New Client CSV Files\TEMPLATE_newClient.csv

Checking PowerShell modules...
WARNING: Module not found: ActiveDirectory
WARNING: Module not found: ExchangeOnlineManagement
```

Those warnings are expected unless the machine has RSAT and Microsoft 365 admin modules installed.

## Project Status

| Status | Details |
|---|---|
| GitHub/portfolio ready | Yes |
| Production-ready without customization | No |
| Requires environment configuration | Yes |
| Requires AD/M365 admin permissions | Yes |
| Includes onboarding and offboarding workflow | Yes |

## Limitations

- Placeholder values must be replaced for a real company tenant.
- Some workflows still require manual admin portal steps, such as license assignment, Duo/MFA handling, and certain 3CX tasks.
- Scripts should be tested in a lab or controlled admin environment before production use.
- Error handling and logging can be expanded further for enterprise-grade deployment.

## Portfolio Summary

This project demonstrates practical IT support automation for a Windows and Microsoft 365 environment. It is designed to show hands-on experience with onboarding, offboarding, Active Directory, Microsoft 365, Teams, SharePoint, documentation, validation, and repeatable helpdesk operations.
