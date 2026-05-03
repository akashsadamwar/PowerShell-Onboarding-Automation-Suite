# Setup Guide

Use this guide to prepare an administrator workstation before running the onboarding scripts.

## Workstation Requirements

- Windows 10 or Windows 11
- PowerShell 5.1 or later
- RSAT Active Directory tools
- Network access to domain controllers
- Admin permissions for the target AD OUs and groups
- Microsoft 365 admin permissions for Exchange, Teams, SharePoint, and group management

## Required Modules

Install modules from an elevated PowerShell session where appropriate:

```powershell
Install-Module ExchangeOnlineManagement
Install-Module MicrosoftTeams
Install-Module Az.Resources
Install-Module PnP.PowerShell
```

The `ActiveDirectory` module is normally installed through RSAT:

```powershell
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online
```

## Environment Configuration

1. Copy `config.example.json` to a private environment-specific config file.
2. Replace placeholder domains, SharePoint URLs, OU paths, group names, and policy names.
3. Confirm `COMPANY_RDS_REQUIRED-TEMPLATE.rdp` points to the correct RDS gateway.
4. Do not commit real tenant names, admin accounts, or internal server names to a public repository.

## Validation

Run this before using the scripts:

```powershell
.\Validate-OnboardingProject.ps1
```

The validator checks required files, CSV headers, and whether common PowerShell modules are available.
