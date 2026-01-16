## Overview
I've been terminated from my employment at Meta. My MacBook and iPhone are Meta provided. This doc outlines the plan for how to recover my data when I buy a new phone and laptop.

## Timeline & Priority
- **CRITICAL**: Complete all data backup steps BEFORE returning devices
- **HIGH**: Sign out of personal accounts to prevent data loss
- **MEDIUM**: Document important settings, configurations, and workflows

## Laptop (MacBook) Recovery Plan

### ⚠️ Critical: Understanding macOS Sign Out Implications

#### What Happens When You Sign Out of iCloud on macOS

**BEFORE signing out, you MUST understand these implications:**

1. **Desktop & Documents Sync**
   - If iCloud Drive is syncing Desktop & Documents folders, signing out will:
     - Remove all synced files from the Mac (they stay in iCloud)
     - You'll be prompted to keep a local copy - **ALWAYS choose "Keep a Copy"**
   - If you don't keep a copy, files only exist in iCloud and won't be on this Mac

2. **Photos Library**
   - If using iCloud Photos:
     - Optimized photos (not fully downloaded) will be removed from the Mac
     - You'll be prompted to keep or delete photos - **choose "Keep a Copy"**
     - Full-resolution originals remain in iCloud and accessible from iCloud.com

3. **Safari Data**
   - Bookmarks, Reading List, and open tabs synced via iCloud will remain in iCloud
   - Local Safari data stays on the Mac unless you clear it separately

4. **Keychain**
   - iCloud Keychain passwords will be removed from this Mac
   - They remain accessible from other devices and iCloud.com
   - **Critical**: Ensure you have access to passwords on another device or password manager

5. **Messages, Mail, Calendar, Contacts**
   - iCloud Messages will be removed but remain in iCloud
   - Mail accounts will be removed from Mail app (but emails stay in cloud)
   - Calendar and Contacts sync will stop but data remains in iCloud

#### How to Properly Sign Out of iCloud on macOS

**Step-by-step process:**

1. **First, verify your data is in iCloud:**
   ```
   - Go to iCloud.com in a browser
   - Sign in with your personal Apple ID
   - Verify you can see your Photos, Files, Contacts, etc.
   ```

2. **Create a local backup of critical files:**
   ```
   - Copy Desktop folder to an external drive or USB
   - Copy Documents folder to external drive
   - Export SSH keys: cp -r ~/.ssh ~/Desktop/ssh_backup
   - Export git config: cp ~/.gitconfig ~/Desktop/gitconfig_backup
   - Screenshot any important settings or app configurations
   ```

3. **Open System Settings (or System Preferences on older macOS):**
   ```
   - Click Apple menu () > System Settings
   - Click your name at the top (Apple ID section)
   ```

4. **Review what's synced:**
   ```
   - Click "iCloud" in the sidebar
   - Note what services are enabled (Photos, Drive, etc.)
   - Take screenshots for reference
   ```

5. **Sign Out:**
   ```
   - Scroll to bottom and click "Sign Out"
   - You'll see a prompt for each service asking if you want to keep a copy
   - **CRITICAL**: Select "Keep a Copy" for:
     ✓ iCloud Drive files
     ✓ Contacts
     ✓ Calendars
     ✓ Safari data
     ✓ Photos (if you have space on the Mac)
   ```

6. **What to DELETE (don't keep):**
   ```
   - You can choose NOT to keep copies of:
     - Very large photo libraries (if confirmed in iCloud.com)
     - Large files already backed up elsewhere
   ```

#### How to Sign Out of Other Personal Accounts on macOS

**Google Account:**
1. Open Safari/Chrome and go to accounts.google.com
2. Click your profile icon > Sign out
3. For Chrome: Settings > You and Google > Turn off sync
4. Remove from Mail app: System Settings > Internet Accounts > Remove Google

**GitHub:**
1. Open Safari/Chrome and sign out of github.com
2. Remove GitHub credentials from Keychain:
   - Open Keychain Access app
   - Search for "github"
   - Delete any personal GitHub tokens/passwords
3. Remove SSH keys (already backed up):
   ```bash
   # List SSH keys
   ls -la ~/.ssh
   # Don't delete yet - just document which are yours
   ```

**Other Services:**
1. Mail app: System Settings > Internet Accounts > Remove all personal accounts
2. Slack: Open Slack > Sign Out of All Workspaces
3. Browser: Sign out of all personal accounts in Safari/Chrome
4. VS Code / IDEs: Sign out of GitHub, Microsoft accounts

### Personal Data to Backup
- [ ] Documents folder (check for personal files)
- [ ] Desktop files
- [ ] Downloads folder (important files)
- [ ] Screenshots and screen recordings
- [ ] SSH keys (~/.ssh/) - **CRITICAL**
- [ ] Git configurations (~/.gitconfig)
- [ ] Browser data (bookmarks, saved passwords if not synced)
- [ ] Development environment configs (.zshrc, .bashrc, etc.)
- [ ] Application preferences and settings
- [ ] Any local-only notes or documents

### Cloud Services Verification
- [ ] GitHub: Verify all repos are pushed and accessible
- [ ] Google Drive: Confirm all files synced
- [ ] iCloud: Check what's synced (Documents, Desktop, Photos)
- [ ] Dropbox/OneDrive: If used, verify sync status
- [ ] Other cloud storage: Notion, Obsidian Sync, etc.

### Before Returning Device
- [ ] **Sign out of personal iCloud account**
- [ ] Sign out of personal Google account
- [ ] Sign out of personal GitHub account
- [ ] Remove any personal email accounts from Mail app
- [ ] Sign out of personal Slack workspaces
- [ ] Sign out of personal Discord/social accounts
- [ ] Clear browser history and saved passwords (if any personal data)
- [ ] Remove any personal VPN configurations
- [ ] Document any important development environment setup

### New Laptop Setup Checklist
- [ ] Sign into iCloud
- [ ] Install essential apps (Obsidian, dev tools, etc.)
- [ ] Clone GitHub repositories
- [ ] Restore SSH keys
- [ ] Configure development environment
- [ ] Set up VPN/security tools
- [ ] Restore browser bookmarks and extensions

## iPhone Recovery Plan

### ⚠️ Critical: Understanding iOS Sign Out Implications

#### What Happens When You Sign Out of iCloud on iPhone

**BEFORE signing out, you MUST understand these implications:**

1. **iCloud Photos**
   - **WARNING**: If you sign out without a backup, photos NOT fully downloaded to the device will be LOST
   - "Optimize iPhone Storage" means many photos are low-res thumbnails only
   - Signing out gives you options:
     - "Keep on My iPhone" - Downloads all photos to device (requires storage space)
     - "Delete from My iPhone" - Removes photos from device (they stay in iCloud)
   - **Full-resolution photos remain in iCloud.com** - verify access before signing out

2. **iCloud Backup**
   - Your iPhone backup remains in iCloud for 180 days after last update
   - Signing out does NOT delete your backup
   - You can restore from this backup on a new iPhone
   - **CRITICAL**: Complete a backup BEFORE signing out

3. **Messages**
   - If "Messages in iCloud" is enabled:
     - All messages remain in iCloud
     - Signing out removes them from this iPhone
     - They'll reappear when you sign in on a new device
   - If NOT enabled:
     - Messages are only stored locally
     - **MUST back up before signing out or they're lost**

4. **Contacts, Calendar, Reminders, Notes**
   - These remain in iCloud when you sign out
   - Will be removed from this iPhone
   - Accessible from iCloud.com and will re-sync to new iPhone

5. **Apps Using iCloud**
   - App data synced to iCloud remains in iCloud
   - Some apps may lose local data if not separately backed up
   - Check each critical app (banking, health, etc.)

6. **Find My iPhone**
   - You MUST disable "Find My iPhone" to sign out
   - This is a security feature to prevent theft
   - Requires your Apple ID password

7. **What STAYS on iPhone After Sign Out**
   - Photos IF you choose "Keep on My iPhone"
   - Locally stored music, apps, and app data
   - Non-iCloud text messages (if Messages in iCloud is off)
   - Health data (always stored locally)
   - Apple Pay cards (stored in Secure Enclave)

#### How to Properly Sign Out of iCloud on iPhone

**Step-by-step process:**

1. **First, verify iCloud backup is complete and recent:**
   ```
   Settings > [Your Name] > iCloud > iCloud Backup
   - Check "Last Backup" time (should be recent)
   - If not recent, tap "Back Up Now" and wait for completion
   - Keep iPhone plugged in and on Wi-Fi during backup
   ```

2. **Check what's in your backup:**
   ```
   Settings > [Your Name] > iCloud > Manage Account Storage > Backups
   - Tap your iPhone name
   - Review size and what's included
   - Note any apps with large data
   ```

3. **Verify data is accessible in iCloud.com:**
   ```
   - Open Safari on iPhone or another device
   - Go to iCloud.com
   - Sign in with your Apple ID
   - CHECK:
     ✓ Photos are all there
     ✓ Contacts are present
     ✓ Drive has your files
     ✓ Notes are accessible
   ```

4. **Check Messages sync status:**
   ```
   Settings > [Your Name] > iCloud > Show All
   - Look for "Messages"
   - If ON: Messages are in iCloud (safe to sign out)
   - If OFF: Messages are local only (will be in backup)
   ```

5. **Check photo storage setting:**
   ```
   Settings > Photos > iCloud Photos
   - Note if using "Optimize iPhone Storage" or "Download and Keep Originals"
   - If optimized, many photos are thumbnails only
   ```

6. **Export critical data not in iCloud:**
   ```
   Health Data:
   - Settings > Health > Profile > Export Health Data
   - This creates a ZIP file you can AirDrop or save

   WhatsApp:
   - Open WhatsApp > Settings > Chats > Chat Backup
   - Back up to iCloud if not automatic

   Banking/Finance Apps:
   - Screenshot account numbers, routing numbers
   - Ensure you can log in from web browser
   ```

7. **Now you can sign out:**
   ```
   Settings > [Your Name] > Sign Out
   - Enter Apple ID password
   - You'll see prompts for each service
   ```

8. **Critical decision - "Keep a Copy" prompts:**
   ```
   You'll be asked about keeping copies of:

   ✓ KEEP: Photos (if you have storage space)
   ✓ KEEP: Safari data
   ✓ KEEP: Contacts
   ✓ KEEP: Calendars
   ✓ KEEP: Reminders
   ✓ KEEP: Notes

   ⚠️  Only SKIP if:
   - Device has no storage space for photos
   - You verified everything is in iCloud.com
   - You have another Apple device with same data
   ```

9. **Disable Find My:**
   ```
   - During sign out, you'll be prompted to turn off Find My
   - Enter your Apple ID password to disable
   - This is required to complete sign out
   ```

10. **Verify sign out completed:**
    ```
    Settings > Check that your name is no longer at the top
    Should say "Sign in to your iPhone" instead
    ```

#### How to Sign Out of Other Personal Accounts on iPhone

**Mail Accounts:**
```
Settings > Mail > Accounts
- Tap each personal account (Gmail, Outlook, etc.)
- Tap "Delete Account"
- This removes from Mail app only, doesn't delete the account
```

**App Store:**
```
Settings > [Your Name] > Media & Purchases > Sign Out
- This signs you out of App Store only
- Apps remain on phone but can't update
- Or already signed out with iCloud sign out
```

**Banking and Financial Apps:**
```
For EACH app:
1. Open the app
2. Find Settings or Profile section
3. Select "Sign Out" or "Log Out"
4. Some apps require you to remove Face ID/Touch ID separately
```

**Social Media Apps:**
```
Each app is different:
- Facebook: Menu > Settings > Security > Log Out
- Instagram: Profile > Menu > Settings > Log Out
- Twitter/X: Profile > Settings > Account > Log Out
- LinkedIn: Profile > Settings > Sign Out
```

**Messaging Apps:**
```
WhatsApp:
- Settings > Account > Delete My Account (only if you want to delete)
- Or leave signed in if you backed up to iCloud

Signal:
- Settings > Account > Delete Account (or leave for new device)

Telegram:
- Settings > Log Out (data is cloud-based)
```

**Two-Factor Authenticator Apps:**
```
⚠️ CRITICAL - DO NOT sign out or delete these apps until:
1. You have backup codes for all accounts
2. You have another device with 2FA set up
3. You've documented which accounts use which 2FA

Authy: Backs up to cloud automatically
Google Authenticator: Export accounts first (Settings > Transfer accounts)
Microsoft Authenticator: Cloud backup should be enabled
```

**Password Manager Apps:**
```
1Password / LastPass / Bitwarden:
- Do NOT sign out until you verify access on another device
- These are your keys to all accounts
- Keep logged in until very last moment
```

#### What NOT to Do

**DON'T:**
- ❌ Factory reset the iPhone before signing out of iCloud
- ❌ Sign out without completing iCloud backup first
- ❌ Choose "Delete from My iPhone" for photos without verifying iCloud access
- ❌ Sign out of 2FA apps before backing up codes
- ❌ Remove password manager until you have access elsewhere
- ❌ Sign out of iCloud if you have < 50% battery and no charger

#### After Signing Out - Before Returning Device

**Final cleanup checklist:**
```
1. Clear Safari:
   Settings > Safari > Clear History and Website Data

2. Remove stored passwords (if any local ones):
   Settings > Passwords > Review and delete personal entries

3. Remove VPN profiles:
   Settings > General > VPN & Device Management

4. Remove Wi-Fi networks:
   Settings > Wi-Fi > (i) icon > Forget This Network
   (For home/personal networks)

5. Check what's still on device:
   Settings > General > iPhone Storage
   - Review what data remains
   - Delete any sensitive personal files

6. Do NOT factory reset unless HR specifically requests it
   - Signing out of iCloud is usually sufficient
   - Factory reset may be done by IT department
```

### Personal Data to Backup
- [ ] Photos (verify iCloud Photos backup is complete)
- [ ] Contacts (should be synced to iCloud)
- [ ] Messages (iCloud Messages should be enabled)
- [ ] Notes (iCloud sync)
- [ ] Health data (can only be transferred via encrypted backup)
- [ ] App data (most should be cloud-synced)
- [ ] Voice memos
- [ ] WhatsApp/Signal backups

### Before Returning Device
- [ ] **Verify iCloud backup is complete and recent**
- [ ] Check iCloud.com to confirm data is accessible
- [ ] Sign out of personal iCloud account
- [ ] Sign out of personal Apple ID from App Store
- [ ] Remove personal email accounts
- [ ] Sign out of banking/financial apps
- [ ] Sign out of social media apps
- [ ] Remove Face ID/Touch ID data
- [ ] Export any non-cloud-backed data (health data, specific apps)

### iCloud Verification Steps
1. Go to Settings > [Your Name] > iCloud
2. Check storage usage and what's being backed up
3. Force a manual backup: Settings > [Your Name] > iCloud > iCloud Backup > Back Up Now
4. Verify on iCloud.com that data is accessible

### New iPhone Setup Checklist
- [ ] Restore from iCloud backup
- [ ] Verify all photos transferred
- [ ] Check contacts and messages
- [ ] Re-download essential apps
- [ ] Set up Face ID/Touch ID
- [ ] Configure email accounts
- [ ] Set up Apple Pay
- [ ] Install authenticator apps and restore 2FA

## Account Security

### Two-Factor Authentication
- [ ] Ensure 2FA apps are backed up (Authy, Google Authenticator)
- [ ] Document backup codes for critical accounts
- [ ] Update phone numbers for SMS-based 2FA after getting new phone

### Password Management
- [ ] Ensure password manager is cloud-synced (1Password, LastPass, etc.)
- [ ] Verify access to password manager on another device

## Critical Accounts Checklist
- [ ] Banking and financial institutions
- [ ] Email accounts
- [ ] Social media
- [ ] Professional accounts (LinkedIn, etc.)
- [ ] Cloud storage
- [ ] Subscription services
- [ ] Developer accounts
- [ ] Domain registrars
- [ ] Cryptocurrency wallets (if applicable)

## Post-Termination Action Items
- [ ] Update resume and LinkedIn
- [ ] Network with former colleagues (personal contact info)
- [ ] Apply for unemployment benefits (if applicable)
- [ ] Update health insurance information
- [ ] Review non-compete and confidentiality agreements
- [ ] Set up job search tracking system

## Notes & Considerations
- Meta will likely require device return within 24-48 hours
- Do NOT transfer any Meta proprietary data or code
- Focus on personal data and publicly available resources
- Keep documentation of what you back up for your records