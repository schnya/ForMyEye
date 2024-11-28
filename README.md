# ForMyEyes

_ForMyEyes_ is a productivity app designed to help users track their screen usage and manage their time effectively. This app also features a memo system with random notifications to remind you of important notes.

## Features

- **Screen Time Tracking**: Monitors your usage and notifies you at regular intervals (e.g., 10 minutes, 20 minutes).
- **Memo Management**: Create, edit, and delete memos with ease.
- **Random Notifications**: Sends reminders from your memos at random intervals to keep important thoughts fresh.

---

## Installation Guide

### Prerequisites

1. **Apple ID**: A free Apple ID is sufficient, but a paid Developer Account is required for unlimited installation.
2. **Mac with Xcode Installed**: Download the latest version of Xcode from the [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).
3. **iPhone or iPad**: Ensure you have the device you want to install the app on.

---

### Steps to Install

#### 1. Clone the Repository

1. Open Terminal and run:

```bash
git clone https://github.com/schnya/ForMyEyes.git
```

2. Navigate to the project directory:

```
cd ForMyEyes
```

### 2. Open the Project in Xcode

1. Locate the cloned repository folder and double-click `ForMyEyes.xcodeproj` to open the project in Xcode.
2. In Xcode, ensure the project target is set to your iOS app by selecting it in the left sidebar.
3. Confirm your app's **Bundle Identifier** and **Signing & Capabilities** settings match your Apple ID configuration.

---

### 3. Connect Your iOS Device

1. Plug in your iPhone or iPad using a USB cable or ensure Wi-Fi connection is enabled:

   - For Wi-Fi setup, go to **Window > Devices and Simulators** in Xcode, select your device, and enable **Connect via network**.

2. Select your device from the dropdown menu in Xcode's top toolbar.

---

### 4. Set Up Signing and Capabilities

1. In Xcode, go to the **Signing & Capabilities** tab under your app target.
2. Select your **Team** (Apple ID). If your Apple ID is not listed, add it under **Xcode > Preferences > Accounts**.
3. Xcode will automatically generate a provisioning profile for your device.

---

### 5. Build and Install the App

1. Click the **Run** button (the ▶️ symbol) in the Xcode toolbar.
2. If you encounter any errors, verify the steps above and clean the build folder with `Shift + Command + K`.
3. Once the app installs on your device, you may need to trust the developer profile:

   - Open **Settings > General > Device Management** on your iPhone or iPad.
   - Select your Apple ID and tap **Trust**.

---

## Troubleshooting

### 1. Trust Issues

- **Ensure you select “Trust”** on your iPhone or iPad when prompted during the initial connection to your Mac.
- Double-check the **Device Management settings** on your iPhone or iPad:
  - Go to **Settings > General > Device Management** and ensure your Apple ID is trusted.

### 2. Provisioning Profile Errors

- **Apple ID in Xcode**:
  - Confirm your Apple ID is added in Xcode under **Xcode > Preferences > Accounts**.
- **Clean the Build Folder**:
  - Use `Shift + Command + K` to clean your project, then rebuild.

### 3. Device Not Showing in Xcode

- **Wi-Fi Debugging**:
  - Ensure both your Mac and iOS device are connected to the same Wi-Fi network.
  - Re-enable **Connect via network** under **Window > Devices and Simulators** in Xcode.
- **Reconnect via USB**:
  - Plug in your device again to re-establish trust.

### 4. App Not Opening After Installation

- Ensure you have “trusted the developer”:
  - Go to **Settings > General > Device Management**, select your Apple ID, and tap **Trust**.

---

## FAQ

### How long will the app remain on my device?

- **Free Apple ID**: The app will expire after **7 days**, requiring you to reinstall via Xcode.
- **Paid Apple Developer Account**: The app does **not expire** and can remain on your device indefinitely.

### Can I share this app with others?

- This guide is intended for **personal use only**. To share the app:
  - Use **TestFlight** for beta testing.
  - Publish it on the **App Store** for public distribution.

---

## License

This project is licensed under the **MIT License**. You are free to use and modify it for personal use. See the `LICENSE` file for more details.
