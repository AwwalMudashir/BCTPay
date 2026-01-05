 # BCTPay

## Table of Contents
- [LOGO](#logo)
- [Description](#description)
- [Contributors](#contributors)
- [Flutter Doctor Log](#flutter-doctor-log)
- [OS](#os)
- [Localization](#localization)
- [Firebase Push notifications](#firebase-push-notifications)
- [Architecture](#architecture)
- [Current gitlab branch we are working on](#current-gitlab-branch-we-are-working-on)
- [Boilerplate Features:](#boilerplate-features)
- [Up-Coming Features:](#up-coming-features)
- [Project Configuration](#project-configuration)
- [How to compile the app](#how-to-compile-the-app)
- [If you got following error in launching](#if-you-got-following-error-in-launching)
- [Conclusion](#conclusion)






## Logo
<img src="assets/images/blacklogo1024.png" alt="logo" style="height:100px; width:100px;"/>

## Description
BCTPay: All-in-One Super App for Mobile Recharge, MOMO Transactions, and Eco Bank Access
 Introducing BCTPay, the ultimate convenience app that takes care of all your essential financial needs!

 Recharge on the Go: Never run out of talk time or data again! BCTPay makes mobile recharge a breeze. Top up your prepaid plans for any operator in India with just a few taps. Whether it's Airtel, Jio, Vi, or BSNL, we've got you covered.

 Effortless MOMO Transactions: Manage your MOMO wallet with ease directly through BCTPay. Send and receive money instantly, pay bills seamlessly, and top up your wallet anytime, anywhere. Say goodbye to long queues and cash hassles!

 Eco Bank at Your Fingertips: Enjoy direct access to your Eco Bank account right within the BCTPay app. View your balance, check transaction history, transfer funds, and even make payments to merchants – all without ever leaving the app.

 BCTPay is more than just transactions, it's about:

Security: Your money and data are safe with us. BCTPay utilizes cutting-edge security measures to ensure your financial transactions are always protected.
Convenience: Manage all your essential financial needs in one place, anytime, anywhere. No more juggling multiple apps!
Speed: Experience lightning-fast transactions and recharges. Say goodbye to waiting in lines or dealing with slow transfers.
Rewards: Earn exciting rewards and cashback offers on every transaction you make through BCTPay.
 Download BCTPay today and experience the future of financial convenience!

## Contributors
**Name**: `Raj kumar Patel`
**Email**: `rajkumar.patel@impetrosys.com`

## Flutter Doctor Log
##### You can find the flutter SDK version and Dart sdk version here
```cmd
✓] Flutter (Channel stable, 3.32.4, on macOS 15.1.1 24B91 darwin-arm64, locale en-IN) [8.3s]
    • Flutter version 3.32.4 on channel stable at /Users/rajkumar/Desktop/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 6fba2447e9 (2 weeks ago), 2025-06-12 19:03:56 -0700
    • Engine revision 8cd19e509d
    • Dart version 3.8.1
    • DevTools version 2.45.1

[✓] Android toolchain - develop for Android devices (Android SDK version 36.0.0-rc1) [17.2s]
    • Android SDK at /Users/rajkumar/Library/Android/sdk
    • Platform android-36, build-tools 36.0.0-rc1
    • Java binary at: /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/java
      This is the JDK bundled with the latest Android Studio installation on this machine.
      To manually set the JDK path, use: `flutter config --jdk-dir="path/to/jdk"`.
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 16.1) [15.6s]
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 16B40
    • CocoaPods version 1.16.2

[✓] Chrome - develop for the web [54ms]
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2024.2) [52ms]
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)

[✓] VS Code (version 1.101.2) [46ms]
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.112.0

[✓] Connected device (3 available) [12.6s]
    • SM M115F (mobile) • 192.168.190.173:44565 • android-arm    • Android 12 (API 31)
    • macOS (desktop)   • macos                 • darwin-arm64   • macOS 15.1.1 24B91
      darwin-arm64
    • Chrome (web)      • chrome                • web-javascript • Google Chrome 138.0.7204.49

[✓] Network resources [2.0s]
    • All expected network resources are available.

• No issues found!
```
## Development Tool

##### Visual Studio Code
- Version: 1.85.1 (Universal)
- Commit: 0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2
- Date: 2023-12-13T09:48:06.308Z
- Electron: 25.9.7
- ElectronBuildId: 25551756
- Chromium: 114.0.5735.289
- Node.js: 18.15.0
- V8: 11.4.183.29-electron.0
- OS: Darwin arm64 23.1.0

##### XCode
- Version: 14 (Universal)

## OS
MacOs Sonoma 14.1 (23B73)

## Localization
You can find all the localization files in the `lib/l10n/` directory

currently we have intl_en.arb and intl_fr.arb files
so we have two language support which is English and French

#### Process
- You have to add keys and translated values in the arb files
- After key and value added you have to run `flutter pub get` command in the terminal or via flutter pub get option in the editor
- Then you can use the keys with `appLocalizations(context).[key]` or `AppLocalizations.of(context)!.[key]`, [key] should be replaced by added key in the arb file

## Firebase push notifications

### IOS APNs setup
- Generate APNs and Auth key

follow the process given in the link below
https://firebase.flutter.dev/docs/messaging/apple-integration#linking-apns-with-fcm

## Architecture
We are using `Bloc-architecture` for this project
```
flutter-app/
|- android
|- build
|- ios
|- assets/
         - images
         - fonts
|- lib/
      - app_routes
      - bloc
      - data/
           - api
           - firebase
           - repository
           - shared_pref
      - extensions
      - globals
      - helper
      - l10n
      - models
      - theme
      - views/
           - auth
           - home
           - kyc
           - list_items
           - mobile_recharge
           - notification
           - onboard
           - transaction
           - user
           - widget
|- test
```
## Current gitlab branch we are working on
Current working branch is `development`

## Boilerplate Features:
We have done following in present in this project:
- Splash screen
- Intro screens
- Login
- SignUp
- Forgot Password
- OTP Screen
- Dashboard
- Account Setting
- Update Profile
- Update Profile Picture
- Localization
- KYC Detail
- KYC Form
- KYC Update
- Dark/Light Mode
- Transaction List
- Transaction Detail with share and download transaction slip
- Blue Dark and Light mode
- New Drawer UI Added
- Add/update/delete/active/inactive/set primary accounts
- Tour navigation implemented
- Security lock added (fingerprint/pattern/passcode) 
- Contact us
- Notifications (clear/ read)
- Push notifications
- Dynamic promotional banners on dashboard
- Transactions (Scan to pay/ Beneficiary Pay/ Self/ Contact/ Subscription / Invoice bill)
- QR code view/ download/ share
- Firebase analytics/crashlytics
- Promotional banner slider on dashboard
- Subscription
- Invoices (Bills)

## Up-Coming Features:
- Coupon codes
- Recharge
- Important links (Security, privacy policy, help & support)
- Data
- Gift Card

## Project Configuration
```yaml
name: bctpay
description: An inclusive Fintech Payment App .

publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=2.19.6 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  # intro_slider: ^4.2.0
  introduction_screen: ^3.1.14
  google_fonts: ^6.2.1
  # otp_text_field: ^1.1.3
  pinput: ^5.0.0
  country_picker: ^2.0.26
  intl: ^0.19.0
  flutter_localizations:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  http: ^1.2.1
  modal_progress_hud_nsn: ^0.5.1
  fluttertoast: ^8.2.6
  loading_animation_widget: ^1.2.1
  shared_preferences: ^2.2.3
  awesome_dialog: ^3.2.1
  # contacts_service: ^0.6.3
  qr_code_scanner: ^1.0.1
  # momo_vn: ^2.0.2
  iso8601_duration: ^0.0.4
  permission_handler: ^11.3.1
  # flutter_contacts: ^1.1.7+1
  # contacts_service: ^0.6.3
  fast_contacts: ^4.0.0
  currency_formatter: ^2.2.0
  another_flushbar: ^1.12.30
  dpad_container: ^2.0.4
  language_code: ^0.5.3+2
  image_picker: ^1.1.2
  firebase_core: ^3.3.0
  firebase_messaging: ^15.0.4
  share_plus: ^10.0.0
  screenshot: ^3.0.0
  path_provider: ^2.1.4
  document_file_save_plus: ^2.0.0
  webview_flutter: ^4.8.0
  flutter_dotenv: ^5.1.0
  country_flags: ^3.0.0
  cached_network_image: ^3.4.0
  encrypt: ^5.0.3
  tutorial_coach_mark: ^1.2.11
  local_auth: ^2.3.0
  local_auth_android: ^1.0.38
  local_auth_darwin: ^1.4.0
  # currency_text_input_formatter: ^2.1.11
  qr_flutter: ^4.1.0
  connectivity_plus: ^6.0.4
  device_info_plus: ^11.1.0
  carousel_slider: ^5.0.0
  smooth_page_indicator: ^1.2.0
  # scan: ^1.6.0
  qr_code_tools: ^0.1.0
  firebase_crashlytics: ^4.0.4
  firebase_analytics: ^11.2.1
  flutter_staggered_animations: ^1.1.1
  flutter_local_notifications: ^18.0.0
  flutter_jailbreak_detection: ^1.10.0
  tuple: ^2.0.2
  crypto: ^3.0.3
  url_launcher: ^6.3.0
  uni_links2: ^0.6.0+2
  scratcher: ^2.5.0
  pdf: ^3.11.1
  image_cropper: ^8.0.1
  camera: ^0.11.0+2
  camera_android_camerax: 0.6.7+2
  flutter_staggered_grid_view: ^0.7.0
  readmore: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^5.0.0

  flutter_launcher_icons: ^0.14.1

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  remove_alpha_ios: true
  image_path: "assets/images/whitelogo1024.png"
  min_sdk_android: 21 # android min sdk min:16, default 21
  web:
    generate: true
    image_path: "assets/images/whitelogo1024.png"
    background_color: "0xffffffff"
    theme_color: "0xffffffff"
  windows:
    generate: true
    image_path: "assets/images/whitelogo1024.png"
    icon_size: 48 # min:48, max:256, default: 48
  macos:
    generate: true
    image_path: "assets/images/whitelogo1024.png"

flutter:
  uses-material-design: true
  generate: true

  # flutter_assets:
  #   assets_path: assets/images/
  #   output_path: lib/globals/assets/
  #   package: module_home

  assets:
    - assets/images/
    - .env
    - .env.production
    - .env.development

flutter_intl:
  enabled: true

```

## How to compile the app

here is a description on how to compile BCTPay project in flutter:

### Requirements:

- Flutter SDK
- Android Studio or Visual Studio Code
- git

#### Steps:

Clone the BCTPay project repository
 git clone https://gitlab.com/bctfintech/bct_projects/bctpay/mobile-app-fe.git
Change directory to the cloned repository
 cd bctpay
Install the required dependencies
 flutter pub get
 (Optional) Configure the project for your specific needs. This may involve editing the pubspec.yaml file or other configuration files.

#### Build the project

* Build apk
 `flutter build apk`

 * Build apk for producion flavor
 `flutter build apk --flavor production --target lib/main_production.dart`
 
 * Build apk for development flavor
 `flutter build apk --flavor development --target lib/main_development.dart`

Run the app on your device or emulator

 `flutter run`

Run for production flavor

 `flutter run --flavor production --target lib/main_production.dart`

Run for development flavor

 `flutter run --flavor development --target lib/main_development.dart`

Or you have to edit launch.json file for vscode if you want to run directly

add following configurations in the launch.json

```json
{
            "name": "development",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_development.dart",
            "args": [
                "--flavor",
                "development",
                "--target",
                "lib/main_development.dart"
            ],
        },
        {
            "name": "production",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_production.dart",
            "args": [
                "--flavor",
                "production",
                "--target",
                "lib/main_production.dart"
            ],
        }
```

## How to Change WL_ID in Customer Mobile App Project

In the customer mobile app project, the WL_ID (White Label ID) can be configured for different environments by modifying the appropriate environment files. Follow these steps to change the WL_ID for each environment:

### 1. Default Environment:
•  Open the .env file located in the root directory of your project.

•  Locate the line that defines WL_ID.

•  Update the value of WL_ID to the desired ID.

•  Save the file.

### 2. Development Environment:
•  Open the .env.development file located in the root directory of your project.

•  Locate the line that defines WL_ID.

•  Update the value of WL_ID to the desired ID.

•  Save the file.

### 3. Production Environment:
•  Open the .env.production file located in the root directory of your project.

•  Locate the line that defines WL_ID.

•  Update the value of WL_ID to the desired ID.

•  Save the file.

#### Note: After updating the WL_ID in the respective environment file, ensure to rebuild or restart your application to apply the changes.


Feel free to ask if you need any more details or assistance!

## If you got following error in launching

#### Error: 
while build iOS app in Xcode : Sandbox: rsync.samba (13105) deny(1) file-write-create, Flutter failed to write to a file

#### Solution: 
set `ENABLE_USER_SCRIPT_SANDBOXING` to `No` in the build options in the xcode

### android error
1. namespace error
add namespace in build.gradle file of relative packages like below

`namespace <BUNDLE ID>`

*note: <BUNDLE ID> should be removed by relative package name like `com.example.package`*

2. * What went wrong:
Execution failed for task ':flutter_jailbreak_detection:compileReleaseKotlin'.
> Inconsistent JVM-target compatibility detected for tasks 'compileReleaseJavaWithJavac' (1.8) and 'compileReleaseKotlin' (21).

  Consider using JVM Toolchain: https://kotl.in/gradle/jvm/toolchain
  Learn more about JVM-target validation: https://kotl.in/gradle/jvm/target-validation 

#### solution:

```gradle
        compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
        // coreLibraryDesugaringEnabled true
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }
```

3. * AAPT: error: resource android:attr/lStar not found

What went wrong:
Execution failed for task ':qr_code_tools:verifyReleaseResources'.
> A failure occurred while executing com.android.build.gradle.tasks.VerifyLibraryResourcesTask$Action
   > Android resource linking failed
     ERROR: /Users/rajkumar/Desktop/Raj/Flutter Projects/BCTPay/build/qr_code_tools/intermediates/merged_res/release/mergeReleaseResources/values/values.xml:194: AAPT: error: resource android:attr/lStar not found.

### solution
add this in related build.gradle
```gradle
dependencies {
  implementation 'androidx.core:core-ktx:1.6.0' 
}
```
 
 Additional notes:

You may need to enable developer mode on your device or emulator in order to run the app.
The first time you run the app, you may be prompted to allow Flutter to install a development certificate on your device.
If you encounter any errors during the compilation process, please consult the BCTPay documentation or the Flutter documentation for troubleshooting tips.
 Here are some additional tips for compiling the BCTPay project in Flutter:

Make sure you have the latest version of the Flutter SDK installed.
If you are using Android Studio, you may need to import the project into Android Studio before you can build and run it.
If you are using Visual Studio Code, you can use the Flutter extension to manage your Flutter projects.
The BCTPay project includes a number of example apps that you can use to learn more about how to use the BCTPay library.
 I hope this helps! Let me know if you have any other questions.

## Conclusion
I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂

If you liked my work, don’t forget to ⭐ star the repo to show your support.
