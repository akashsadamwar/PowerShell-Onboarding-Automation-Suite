## PowerShell Onboarding Automation Suite

A collection of PowerShell scripts that automate new user and new client provisioning across Microsoft Active Directory, SharePoint, Microsoft 365, Microsoft Teams, 3CX VoIP, and Duo MFA.

> **Note:** All scripts have been redacted to remove environment-specific values. They are designed for a particular Windows AD infrastructure and will require adaptation before use in any other environment.

---

### Scripts

| Script | Purpose |
|---|---|
| `Create_AD_User.ps1` | Batch provision new users from a CSV file |
| `Create_New_Client.ps1` | Batch provision new client OUs, security groups, and Teams |
| `Copy_ADGroupMembership_UserToUser.ps1` | Mirror AD group membership from one user to another |
| `Copy_ADGroupMembership_GroupToGroup.ps1` | Mirror AD + O365 group membership from one group to another |
| `3cxTeamsSync.ps1` | Link a 3CX user to Microsoft Teams Enterprise Voice |

---

### New User Provisioning (`Create_AD_User.ps1`)

Reads from a CSV file (template: `New User CSV Files/usersTEMPLATE.csv`) and for each row:

1. Creates the AD user account based on a staff template
2. Moves the user to the correct Organizational Unit by domain
3. Copies security group membership from the template user
4. Generates a `.rdp` file for Remote Desktop access
5. Creates an entry in the Employee Tracker SharePoint list and attaches the `.rdp` file
6. Sets proxy addresses, phone numbers, and job title attributes
7. Optionally triggers an AD Delta Sync

**Steps requiring manual intervention:**

- *Before script:* In 3CX — create user, assign DID/extension, add to domain group
- *During script:* In M365 admin — assign license, add to CodeTwo mail-security group, add to any explicitly requested groups
- *After script:* In Duo — run Azure AD sync, set new user(s) to Bypass; run `3cxTeamsSync.ps1` per user to finalize Teams-3CX Enterprise Voice

---

### New Client Provisioning (`Create_New_Client.ps1`)

Reads from a CSV file (template: `New Client CSV Files/TEMPLATE_newClient.csv`) and for each row:

1. Creates a client Organizational Unit in AD
2. Creates a Security Group nested within the new OU
3. Creates a private M365 Unified Group and linked Team
4. Adds specified members and sets ownership

---

### Known Limitations / Pending Automation

- CodeTwo mail-security group assignment is not yet automated — requires manual addition in M365 admin based on user domain
- 3CX Teams sync (`3cxTeamsSync.ps1`) still prompts per-user via console; refactoring to read from the same CSV used for user creation is pending
