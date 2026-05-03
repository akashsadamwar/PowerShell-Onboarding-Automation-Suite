# Troubleshooting Guide

## ActiveDirectory Module Not Found

Install RSAT Active Directory tools on the admin workstation and reopen PowerShell.

## Cannot Connect to Microsoft 365 Services

Confirm the admin account has the required roles and that modern authentication prompts are not blocked by browser or conditional access policy.

## CSV Import Fails

Check that the file is saved as `.csv`, headers match the templates, and values containing commas are wrapped in quotes.

## User Already Exists

Search AD for the generated username. If needed, adjust the CSV or manually choose a unique username according to company naming rules.

## Teams Group Creation Times Out

Microsoft 365 group replication can take time. Wait a few minutes, confirm the group exists in Microsoft 365, then retry Teams creation.

## RDP File Is Not Created

Confirm `COMPANY_RDS_REQUIRED-TEMPLATE.rdp` exists in the script directory and that PowerShell has write access to the folder.

## SharePoint List Update Fails

Confirm the SharePoint site URL, list name, field internal names, and PnP permissions. Field display names may differ from internal field names.

## Offboarding Script Only Shows Planned Actions

This is expected. The offboarding script runs in review mode by default. Add `-Execute` only after confirming the target user and planned actions.
