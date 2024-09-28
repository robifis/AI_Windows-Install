You are an expert at creating Windows answer files and customizing Windows installations without unnecessary bloat. I need your help to create an `autounattend.xml` file for Windows 11 Pro installation and a post-installation PowerShell script (`setup.ps1`) that installs specific applications and applies custom configurations.

Here are my requirements:

1. **Windows Version and Architecture**:
   - Windows 11 Pro, 64-bit.

2. **Language and Regional Settings**:
   - Language: English (United Kingdom).
   - Time Zone: Europe/London.
   - Keyboard Layout: en-GB.

3. **User Accounts**:
   - Create a local administrator account named "adminuser"; I'll set the password manually.
   - Create a user account named "username"; I'll set the password manually and want this account to auto-login.
   - Disable the built-in Administrator account.

4. **Disk Configuration**:
   - Allow me to adjust disk partitions during installation (e.g., for dual-boot setups).

5. **Network Settings**:
   - Use DHCP for automatic IP assignment.
   - Do not join a domain.

6. **Applications to Install**:
   - Using Chocolatey:
     - [List of applications, e.g., TeraCopy, CopyQ, VIM, OBS Studio]
   - Using Winget:
     - [List of applications, e.g., Visual Studio Code, Notepad++, Google Chrome, Firefox, Ubuntu 24.04]

7. **Windows Features to Enable**:
   - Hyper-V.
   - Windows Subsystem for Linux (WSL 2).
   - OpenSSH Client and Server.

8. **Debloating Preferences**:
   - Remove unnecessary pre-installed Windows apps.
   - Retain Microsoft Edge and Windows Terminal.

9. **System Configurations**:
   - Enable dark mode.
   - Set power plan to Ultimate Performance.
   - Set a custom wallpaper from Unsplash.
   - Show desktop icons: This PC, User Folder, Control Panel.
   - Adjust taskbar settings:
     - Align taskbar to the left.
     - Use small taskbar icons.
     - Show all notification icons.

10. **Additional Scripts or Settings**:
    - Any other specific configurations I should consider.

Please provide the complete `autounattend.xml` file and `setup.ps1` script based on these requirements. Also, include instructions on how to use these files during the Windows installation process with Rufus, ensuring that no conflicting options are selected in Rufus.

Thank you!
