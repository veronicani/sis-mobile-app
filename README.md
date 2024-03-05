# sis_mobile_homepage

Flutter project for SIS R35's mobile homepage! (WIP, last updated 2024 Feb 22, 6:20PM PST)

Currently displays the Assessments section of Rithm's upcoming page.
Developed by a team with access to only iOS and OS, so it has yet to be tested for Android compatibility.

![iOS Simulator Screenshot](/sis_mobile_homepage/lib/simulator_screenshot.png)

## Getting Started

Necessary packages to run this application (on Mac):
- Cocoapods ^1.15.2 (installed via Homebrew)
  - To install via Homebrew:
    `brew install cocoapods`
- Xcode
- Flutter SDK
Installation docs (development OS, target iOS): https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=vscode#configure-xcode

### Notes
- This app is currently making API requests to a version of SIS on localhost:8000, so please `python3 manage.py runserver`
- Authentication has yet to be implemented. For testing purposes, in order to get a token, please include `getToken()` during app initialization, and pass in a fake username & password from the SIS fake dev database.
```dart
//In main.dart

void main() {
  runApp(MyApp());
  // sis_api.getToken(fake_username, fake_password); <- Uncomment me! Replace w/ credentials
}
```


