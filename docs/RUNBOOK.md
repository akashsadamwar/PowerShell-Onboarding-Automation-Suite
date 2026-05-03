# Operations Runbook

This runbook describes the intended end-to-end support workflow.

## Employee Onboarding

1. Review the ticket for start date, department, manager, title, hardware, phone, and access requests.
2. Prepare the user CSV from `New User CSV Files/usersTEMPLATE.csv`.
3. Create or confirm any required 3CX extension and DID values.
4. Run `.\Validate-OnboardingProject.ps1`.
5. Run `.\Create_AD_User.ps1`.
6. Assign required Microsoft 365 licenses in the admin portal.
7. Add any requested shared mailbox, distribution list, or application access.
8. Run Duo or MFA synchronization according to company process.
9. Run `.\3cxTeamsSync.ps1` if the user needs Teams voice.
10. Confirm login, Teams, SharePoint, RDS, printer, and device setup.
11. Update the ticket with account, hardware, and completion notes.

## Client Onboarding

1. Review the requested client name, AD path, Microsoft 365 group name, alias, owners, and members.
2. Prepare the client CSV from `New Client CSV Files/TEMPLATE_newClient.csv`.
3. Run `.\Validate-OnboardingProject.ps1`.
4. Run `.\Create_New_Client.ps1`.
5. Confirm the AD OU, security group, Microsoft 365 group, Team, members, and owner.
6. Document the created resources in the ticket or client record.

## Access Copy

Use group-copy scripts when a new user or group should mirror an existing access pattern:

```powershell
.\Copy_ADGroupMembership_UserToUser.ps1 -sourceUsernames existing.user -targetUsernames new.user
```

For group-to-group copying, run:

```powershell
.\Copy_ADGroupMembership_GroupToGroup.ps1
```

Review source and target selections carefully before confirming.

## Employee Offboarding

1. Confirm the offboarding ticket, effective time, manager approval, and retention requirements.
2. Review planned AD changes:

```powershell
.\Offboard_AD_User.ps1 -SamAccountName username
```

3. Apply AD changes only after review:

```powershell
.\Offboard_AD_User.ps1 -SamAccountName username -Execute
```

4. Recover hardware and remove mobile/AV/peripheral assignments.
5. Revoke sessions, remove licenses, process mailbox handling, and confirm MFA/device access is disabled.
6. Close the ticket with clear notes.
