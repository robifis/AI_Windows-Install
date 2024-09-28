# Windows 11 Unattended Installation with Customization

This repository provides a method to create a customized, debloated Windows 11 Pro installation using an answer file (`autounattend.xml`) and a post-installation script (`setup.ps1`). It automates the installation process, debloats unnecessary apps, installs your required applications, and applies system optimizations and customizations.

---

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Prepare Your Preferences](#1-prepare-your-preferences)
  - [2. Generate Custom Files](#2-generate-custom-files)
  - [3. Prepare Installation Media](#3-prepare-installation-media)
    - [3.1. Using Rufus to Create Bootable USB](#31-using-rufus-to-create-bootable-usb)
  - [4. Install Windows 11](#4-install-windows-11)
  - [5. Post-Installation Steps](#5-post-installation-steps)
- [Customization](#customization)
  - [Sample AI Prompt for Customization](#sample-ai-prompt-for-customization)
- [Files in This Repository](#files-in-this-repository)
- [Security Considerations](#security-considerations)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Features

- **Automated Windows 11 Pro Installation**: Uses an answer file to automate the installation process.
- **Custom User Accounts**: Creates specified administrator and user accounts.
- **Debloat Windows**: Removes unwanted pre-installed apps while retaining essential ones like Microsoft Edge and Windows Terminal.
- **Application Installation**: Installs user-specified applications using Chocolatey and Winget package managers.
- **System Optimizations**: Applies system settings for performance and appearance, including enabling dark mode, setting power plans, custom wallpapers, and more.
- **Taskbar and Desktop Customizations**: Adjusts taskbar alignment, size, notification icons, and shows desktop icons like This PC, User Folder, and Control Panel.

---

## Prerequisites

- **Rufus**: Tool to create a bootable USB drive ([Download Rufus](https://rufus.ie/)).
- **USB Drive**: At least 16 GB capacity.
- **Internet Connection**: Required during installation to download Windows 11 ISO, applications, and updates.

---

## Getting Started

Follow these steps to create your customized Windows 11 installation.

### 1. Prepare Your Preferences

Before generating the files, determine your customization preferences:

- **Windows Edition and Architecture**: For example, Windows 11 Pro, 64-bit.
- **Language and Region Settings**: Preferred language, time zone (`Europe/London`), keyboard layout (`en-GB`).
- **User Accounts**: Names for administrator and user accounts (e.g., `adminuser`, `bobby`), whether to auto-login, and password settings.
- **Disk Configuration**: Decide if you'll adjust disk partitions during installation (e.g., for dual-boot setups).
- **Network Settings**: Typically use DHCP unless static IPs are required.
- **Applications to Install**: List applications to install via Chocolatey and Winget.
- **Windows Features to Enable**: Such as Hyper-V, WSL 2, OpenSSH.
- **Debloating Preferences**: Specify which pre-installed apps to remove or retain.
- **System Configurations**: Visual settings (dark mode), performance settings, custom wallpaper, taskbar adjustments.
- **Additional Scripts or Settings**: Any other custom configurations.

### 2. Generate Custom Files

You can generate customized `autounattend.xml` and `setup.ps1` files using an AI assistant like ChatGPT or by manually creating them based on templates.

#### Using AI Assistance

Use the [Sample AI Prompt for Customization](#sample-ai-prompt-for-customization) to generate your files.

#### Manually Creating the Files

- Use the templates provided in this repository (`autounattend.xml` and `setup.ps1`) and modify them according to your preferences.

### 3. Prepare Installation Media

#### 3.1. Using Rufus to Create Bootable USB

Rufus is a utility that helps format and create bootable USB flash drives. It includes a feature to download Windows 11 ISO directly and create a bootable USB drive.

**Important Note**: **Do not check any of the optional settings boxes in Rufus** (such as bypassing TPM, Secure Boot requirements, or using an unattended installation). These options can conflict with your custom `autounattend.xml` file.

**Steps**:

1. **Download and Install Rufus**:

   - Visit the [Rufus website](https://rufus.ie/) and download the latest version.
   - No installation is necessary; Rufus is a portable application.

2. **Insert Your USB Drive**:

   - Plug in a USB drive with at least 16 GB capacity.
   - Ensure any important data on the USB drive is backed up, as it will be formatted.

3. **Launch Rufus**:

   - Run `rufus.exe` with administrative privileges.

4. **Download Windows 11 ISO Using Rufus**:

   - In Rufus, click on the **down arrow** next to the **SELECT** button.
   - Choose **DOWNLOAD** from the dropdown menu.

   ![Rufus Download Option][]

   - Click on the **DOWNLOAD** button.
   - In the **Download ISO Image** dialog:

     - **Version**: Select the desired Windows 11 version.
     - **Edition**: Typically **Windows Home/Pro**.
     - **Language**: Choose your preferred language (e.g., **English (International)**).
     - **Architecture**: Select **x64**.

   - Click **Download** and choose a location to save the ISO file.

5. **Configure Rufus Settings**:

   - **Device**: Ensure your USB drive is selected.
   - **Boot selection**: Should display the downloaded Windows 11 ISO.
   - **Image option**: **Standard Windows installation**.
   - **Partition scheme**: Use **GPT** for UEFI-based systems.
   - **Target system**: Should automatically select **UEFI (non CSM)**.
   - **Volume label**: You can leave the default or set a custom label.
   - **File system**: Leave as **NTFS**.
   - **Cluster size**: Default.

6. **Do Not Modify Extended Windows Installation Options**:

   - **Do NOT check any of the boxes** under **Extended Windows 11 Installation (no TPM / no Secure Boot / 8GB+ RAM)**.
   - **Do NOT check the option to use an answer file or for unattended installation**.

   ![Rufus Settings][]

7. **Start the Process**:

   - Click **START**.
   - A warning will appear about data destruction; confirm to proceed.
   - Rufus will create the bootable USB drive.

8. **Add `autounattend.xml` to USB Drive**:

   - After Rufus finishes, open the USB drive in File Explorer.
   - Place your customized `autounattend.xml` file at the root of the USB drive (e.g., `E:\autounattend.xml`).

9. **Add `setup.ps1` to USB Drive**:

   - Create a folder named `Scripts` at the root of the USB drive (e.g., `E:\Scripts\`).
   - Place your customized `setup.ps1` script inside the `Scripts` folder.

### 4. Install Windows 11

1. **Boot from USB Drive**:

   - Insert the USB drive into the target computer.
   - Boot the computer and select the USB drive as the boot device (you may need to adjust BIOS/UEFI settings).

2. **Automatic Installation**:

   - The Windows Setup will use `autounattend.xml` to automate the installation.
   - When prompted for disk configurations, adjust them as needed (e.g., for dual-boot setups).

3. **First Login**:

   - The system will automatically log in as the specified user (e.g., `bobby`).
   - The `setup.ps1` script will run automatically to perform post-installation tasks.

### 5. Post-Installation Steps

1. **Set User Passwords**:

   - If passwords were not set in `autounattend.xml`, set them manually.
   - Press `Ctrl + Alt + Del` and select **Change a password**.

2. **Activate Windows**:

   - Go to **Settings** > **System** > **Activation** to enter your product key.

3. **Verify Installations and Configurations**:

   - Check that all applications are installed.
   - Ensure system settings and customizations are applied.

4. **Review Log File**:

   - The `setup.ps1` script creates a log file at `C:\setup\post_install_log.txt`.
   - Review the log for any errors or important messages.

---

## Customization

### Sample AI Prompt for Customization

To generate your own customized `autounattend.xml` and `setup.ps1` files using an AI assistant, you can use the following prompt:

---

**AI Assistant Prompt:**

```
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
```

---

### Using the Prompt

- **Copy the prompt** and paste it into the AI assistant.
- **Replace placeholders** like `"username"` and application lists with your actual desired values.
- **Review the generated files** carefully to ensure they match your preferences.
- **Proceed** to use the files as per the instructions.

---

## Files in This Repository

- **`autounattend.xml`**: A template answer file for automating Windows installation.
- **`setup.ps1`**: A template post-installation PowerShell script to configure the system.
- **`README.md`**: This documentation file.

---

## Security Considerations

- **Review All Scripts**: Before executing any scripts, read them thoroughly to understand what they do.
- **Handle Passwords Securely**:
  - Avoid hardcoding passwords in scripts or answer files.
  - If possible, set passwords manually after installation.
- **Download Sources**:
  - Ensure all applications and dependencies are downloaded from trusted sources.
- **Execution Policy**:
  - Be cautious when setting the PowerShell execution policy to `Bypass` or `Unrestricted`.
  - Restore the execution policy to its default setting after installation if necessary.

---

## Troubleshooting

- **Post-Installation Script Doesn't Run**:
  - Verify that `setup.ps1` is correctly copied to `C:\setup\` during installation.
  - Ensure the `FirstLogonCommands` section in `autounattend.xml` is correctly configured.

- **Applications Not Installed**:
  - Check internet connectivity during installation.
  - Review the `setup.ps1` script for errors.

- **Settings Not Applied**:
  - Some settings may require a system restart to take effect.
  - Ensure the script runs with administrator privileges.

- **Log File for Errors**:
  - Check `C:\setup\post_install_log.txt` for any error messages or details.

---

## License

This project is licensed under the [MIT License](LICENSE).

---

**Note**: This repository provides templates and guidance for educational purposes. Customize and use them responsibly according to your needs and legal obligations.

---

If you have any questions or need further assistance, feel free to reach out!

---

**Images**:

In the instructions above, references are made to images (e.g., `rufus_download_option.png`, `rufus_settings.png`). Since images cannot be displayed in a text file, please refer to the Rufus official documentation or website for visual guidance, or consider adding screenshots when you create your own repository.

---

**Additional Notes on Rufus Usage**:

- **Why Not to Modify Extended Options in Rufus**:

  Rufus provides extended options to customize the Windows installation, such as bypassing TPM and Secure Boot checks, or creating an unattended installation with specific settings. Since you are using a custom `autounattend.xml` file, altering these settings in Rufus can cause conflicts, duplicate settings, or override your custom configurations.

- **Ensuring No Conflicts with `autounattend.xml`**:

  By avoiding changes in Rufus's extended options, you ensure that your custom `autounattend.xml` file is the sole source of automation and customization during the Windows installation process.

---

## Summary

By following the steps and using the provided `autounattend.xml` and `setup.ps1` scripts, you'll achieve a clean, debloated Windows 11 Pro installation tailored to your specific needs, with all your required applications installed and system settings configured.

**Remember**:

- Use Rufus to create the bootable USB drive and download Windows 11 ISO.
- Do not select any optional settings in Rufus that could conflict with your custom answer file.
- Place your `autounattend.xml` and `setup.ps1` files in the correct locations on the USB drive.
- Follow the installation and post-installation steps carefully.

