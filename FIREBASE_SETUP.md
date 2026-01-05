# Firebase Setup Guide

## Prerequisites
- A Google account
- Flutter project configured
- Android Studio and/or Xcode installed

## Step-by-Step Firebase Configuration

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `calendario-familiar`
4. Follow the wizard (enable Google Analytics if desired)
5. Click "Create project"

### 2. Add Android App

1. In Firebase Console, click on Android icon
2. Enter package name: `com.example.calendario_familiar`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`
5. Follow the setup instructions (add dependencies to build.gradle files)

#### Update android/build.gradle:
```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

#### Update android/app/build.gradle:
```gradle
apply plugin: 'com.android.application'
// Add this line at the bottom
apply plugin: 'com.google.gms.google-services'

dependencies {
    // Add Firebase BOM
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
}
```

### 3. Add iOS App

1. In Firebase Console, click on iOS icon
2. Enter bundle ID: `com.example.calendarioFamiliar`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`
5. Open Xcode and add the file to the Runner project

### 4. Enable Authentication

1. Go to Firebase Console → Authentication
2. Click "Get started"
3. Click on "Sign-in method" tab
4. Enable "Google" sign-in provider
5. Configure OAuth consent screen if needed

#### Configure Google Sign-In for Android:
1. Get SHA-1 fingerprint:
```bash
cd android
./gradlew signingReport
```
2. Add SHA-1 to Firebase Console (Project Settings → Your apps → Android app)

#### Configure Google Sign-In for iOS:
1. Add URL schemes in `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <!-- Reversed client ID from GoogleService-Info.plist -->
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

### 5. Enable Firestore Database

1. Go to Firebase Console → Firestore Database
2. Click "Create database"
3. Choose "Start in test mode" (will be changed later)
4. Select location (choose closest to your users)
5. Click "Enable"

### 6. Configure Firestore Security Rules

Replace the default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Family data - users must be authenticated
    match /families/{familyId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
                              get(/databases/$(database)/documents/families/$(familyId)).data.adminId == request.auth.uid;
      
      // Family members
      match /members/{memberId} {
        allow read: if request.auth != null;
        allow write: if request.auth != null;
      }
      
      // Events
      match /events/{eventId} {
        allow read: if request.auth != null;
        allow create: if request.auth != null;
        allow update, delete: if request.auth != null;
      }
    }
  }
}
```

### 7. Test the Configuration

1. Run `flutter pub get`
2. Run the app: `flutter run`
3. Try to sign in with Google
4. Create a family and add events
5. Check Firestore Console to verify data is being saved

## Troubleshooting

### Android Issues

**Problem**: Google Sign-In fails
- **Solution**: Make sure SHA-1 fingerprint is added to Firebase Console
- Get debug SHA-1: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`

**Problem**: `google-services.json` not found
- **Solution**: Verify the file is in `android/app/` directory

### iOS Issues

**Problem**: Google Sign-In fails
- **Solution**: Verify `GoogleService-Info.plist` is added to Xcode project
- **Solution**: Check that URL schemes are correctly configured

**Problem**: Firebase not initializing
- **Solution**: Make sure `GoogleService-Info.plist` is in the Runner target

### General Issues

**Problem**: "Firebase has not been initialized"
- **Solution**: Ensure `Firebase.initializeApp()` is called before `runApp()` in main.dart

**Problem**: "Permission denied" in Firestore
- **Solution**: Check Firestore security rules
- **Solution**: Verify user is authenticated

## Firebase Emulator (Optional for Development)

For local development without using production Firebase:

1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init`
4. Start emulators: `firebase emulators:start`
5. Update app to use emulators (see Firebase documentation)

## Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)
- [Cloud Firestore Documentation](https://firebase.google.com/docs/firestore)
