# Project Name

Diccon Dictionary

## MSIX Configuration

Before proceeding, ensure that your MSIX configuration is set up correctly in the `pubspec.yaml` file. The icon's path might need to be updated if you've changed the location path.
C:\Users\Zr\StudioProjects\diccon_evo\assets\dictionary\icon.ico

### Creating an MSIX Package

To create an MSIX installer, follow these steps:

1. Make sure you have the correct version set in your `pubspec.yaml` before creating the package.

2. Open your command prompt or terminal.

3. Run the following command:

   ```bash
   dart run msix:create

## Android Release
When preparing an Android release, make sure to update the versionCode in the AndroidManifest.xml file and the version in the pubspec.yaml file. Here's how:

Open pubspec.yaml and change the version to the desired value (e.g., 1.0.2+2).

Update the versionCode in the AndroidManifest.xml file in your Android project.

## Keystore
Your keystore is stored in the Onedrive Vault. If you need to change the keystore path or any other related settings, follow these steps:

Open the android/key.properties file.

Update the keystore path as necessary.

Don't forget to update the version (e.g., v93) in the Properties view too to change the version displayed in the app.