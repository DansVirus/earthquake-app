# earthquake-app

An earthquake notifier project developed with Dart and Flutter 

[![My Skills](https://skillicons.dev/icons?i=flutter,dart)](https://skillicons.dev)

## Description

A real-time tracker application that fetches earthquake data from a global API. Users can sort earthquakes by magnitude, filter results by a date range¹ and view nearby earthquakes based on their location.

¹Date range is hard-coded up to the year 2000.



## Photos

![alt text](photo.png)

## Key implementations

- Fetch data over internet using http package.
- Short data by magnitude and time.
- Convert JSON to Dart Object.
- Detect device current location using geolocator.
- Convert coordinates into address using geocoding.
- Show data within circular region.
- Use of DatePicker dialog.
- Show data within date range.

## Dependencies used


- [intl](https://pub.dev/packages/intl)
- [provider](https://pub.dev/packages/provider)
- [http](https://pub.dev/packages/http)
- [geolocator](https://pub.dev/packages/geolocator)
- [geocoding](https://pub.dev/packages/geocoding)
- [flutter_easyloading](https://pub.dev/packages/flutter_easyloading)
  
## USGS Earthquake API documentation
- [API documentation](https://earthquake.usgs.gov/fdsnws/event/1/)



## How to run this app.
<h3> Installing Flutter and Necessary Tools</h3>

### Step 1: Download Flutter SDK

1. Visit the official [Flutter website](https://flutter.dev/).
2. Click **Get Started**, which will redirect you to a page with platform-specific options.
3. Choose the appropriate platform for your operating system (Windows, macOS, Linux, or Chrome OS). 
   
   For example:
   - If you're on **Windows**, select the Windows option.
   - For **macOS**, choose the macOS option.
   - For **Linux** or **Chrome OS**, pick the corresponding option.

### Step 2: Check Requirements (For Windows Users)

If you're on Windows, ensure your machine meets the following requirements:
- Windows 10 (64-bit).
- At least 1.64 GB of available disk space.
- **PowerShell** (pre-installed on Windows 10).
- **Git for Windows** (must be installed).

### Step 3: Install Git for Windows

1. Download [Git for Windows](https://git-scm.com/).
2. Ensure you select the version corresponding to your Windows architecture (64-bit).
3. Once downloaded, run the installer and follow the prompts to complete the installation.

### Step 4: Download and Extract the Flutter SDK

1. Download the latest stable version of the Flutter SDK (v3.13.3) from the Flutter website. This will be a `.zip` file.
2. Create a new folder (e.g., `C:\src`) and extract the contents of the zip file into this folder.
   
   **Important**: 
   - Avoid placing the SDK in a directory that contains special characters or requires elevated privileges (e.g., `C:\Program Files`).

### Step 5: Add Flutter to System Path

1. Navigate to `C:\src\flutter\bin` (or wherever you extracted the SDK).
2. Copy the path.
3. Open the **System Environment Variables**:
   - Search for **"Edit the system environment variables"** in the Windows search bar.
   - Click **Environment Variables**.
4. Under **System Variables**, find the `Path` variable:
   - If it doesn’t exist, create it.
   - If it exists, select it and click **Edit**.
5. Click **New** and paste the copied Flutter SDK path.
6. Press **OK** to save.

### Step 6: Add Dart SDK to System Path (Optional)

Flutter includes the Dart SDK, which is located at:
`C:\src\flutter\bin\cache\dart-sdk\bin`.

1. Copy this Dart SDK path.
2. Repeat the steps in **Step 5** to add this path to the system environment variables.
3. Move this path **above** the Flutter SDK path to prioritize it.

---

## Installing Android Studio

### Step 1: Download Android Studio

1. Visit the official [Android Studio website](https://developer.android.com/studio).
2. Click the **Download Android Studio** button.
3. Select the appropriate version for your operating system (Windows, macOS, or Linux).

### Step 2: Install Android Studio

1. Once the download is complete, open the installer and follow the on-screen instructions to install Android Studio.
   
   **For Windows users**:
   - Double-click the `.exe` file to start the installation process.
   - Make sure to select the option to install both Android Studio and the **Android SDK**.
   - You may also be prompted to install an **Android Virtual Device (AVD)**. This will allow you to test your Flutter apps in an emulator.

2. During installation, Android Studio will install the **SDK**, **Emulator**, and **Android SDK Tools**. These components are essential for Flutter app development.

### Step 3: Configure Android Studio

1. After the installation, open Android Studio.
2. Complete the initial setup wizard:
   - It will automatically detect your available system settings and download the necessary components (SDK, platform tools, etc.).
   - Select the default settings unless you have specific preferences.

### Step 4: Install Android SDK Components

1. Once Android Studio is open, click on **More Actions** from the welcome screen and select **SDK Manager**.
2. In the **SDK Platforms** tab:
   - Check the latest stable version of **Android SDK** (usually the latest API level is recommended).
3. In the **SDK Tools** tab:
   - Ensure the following are installed:
     - **Android SDK Build-Tools**
     - **Android Emulator**
     - **Android SDK Platform-Tools**
     - **Android SDK Command-line Tools**

### Step 5: Configure Android Emulator (Optional)

If you wish to run Android apps on an emulator, follow these steps:

1. Go to **Tools > AVD Manager**.
2. Click **Create Virtual Device**.
3. Choose a device (e.g., Pixel 5) and select a system image (e.g., Android 13).
4. Download the system image if necessary, and click **Finish**.

### Step 6: Set Up Android Studio for Flutter Development

1. Open **Android Studio** and navigate to **File > Settings** (or **Preferences** on macOS).
2. Go to **Plugins** and search for the **Flutter** plugin.
3. Click **Install** to add the Flutter plugin.
4. Android Studio will prompt you to install the **Dart** plugin (required for Flutter). Click **Install** when prompted.

### Step 7: Set Up Android Studio Path in System Variables (Windows Users)

To use Android tools in the command line, you need to set the path to the `Android SDK`:

1. Find the path to your Android SDK:
   - In Android Studio, navigate to **File > Settings > Appearance & Behavior > System Settings > Android SDK**.
   - Copy the path to the **Android SDK Location** (e.g., `C:\Users\<YourUserName>\AppData\Local\Android\Sdk`).

2. Add the SDK path to your system environment variables:
   - Open the Windows search bar and type **"Environment Variables"**.
   - Select **Edit the system environment variables**.
   - Click **Environment Variables**.
   - Under **System Variables**, find the `Path` variable, select it, and click **Edit**.
   - Click **New** and paste the path to the Android SDK.
   - Click **OK** to save your changes.
---

## Pulling and Opening a Flutter Project from GitHub

### Step 1: Clone the GitHub Repository

1. Open a terminal or command prompt.
2. Navigate to the directory where you want to clone the project:
3. Clone the repository by running the following command.
4. Once the repository is cloned, navigate into the project folder: Replace repository-url with the actual repository URL
   ```bash
   2. cd path/to/your/directory

   3. git clone https://github.com/username/repository-url.git

   4. cd repository-name

### Step 2: Open the Project in Android Studio:

- Open Android Studio.
- Click Open on the welcome screen.
- Select the cloned project folder and click OK.

### Step 3: Install Project Dependencies
- Open the terminal in your IDE (or a standalone terminal) within the project directory.
- Run the following command to install the necessary Flutter dependencies:
   ```bash
   flutter pub get   
### Step 4: Verify Flutter Setup
- Ensure that your Flutter setup is working correctly by running:
    
      flutter doctor

### Step 5: Select a Device to Run the Project
- Connect an Android device or start an emulator using AVD Manager.
- Select the device from the Device Selector in the toolbar.
### Step 6: Run the Flutter Project
- Run the project by executing the following command in the terminal:
  ```
    flutter run
- Or, use the Run button in Android Studio.

### Step 7: WooHoo
Once the project is running, you're ready to start exploring or developing on the Flutter project!
---
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

