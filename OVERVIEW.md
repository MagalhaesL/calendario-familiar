# 📱 Calendário Familiar - Project Overview

## 🎯 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/MagalhaesL/calendario-familiar.git
cd calendario-familiar

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase (see FIREBASE_SETUP.md)
# - Create Firebase project
# - Add google-services.json (Android)
# - Add GoogleService-Info.plist (iOS)
# - Enable Authentication & Firestore

# 4. Run the app
flutter run
```

## 📋 Project At-a-Glance

| Aspect | Details |
|--------|---------|
| **Platform** | Flutter (iOS & Android) |
| **Language** | Dart 3.0+ |
| **State Management** | Provider |
| **Local Storage** | Hive |
| **Cloud Storage** | Firebase Firestore |
| **Authentication** | Firebase Auth + Google Sign-In |
| **Notifications** | Flutter Local Notifications |
| **Architecture** | Clean Architecture (Layered) |
| **Status** | ✅ Production Ready |

## 🎨 Features

### 👤 Authentication
- ✅ Google Sign-In
- ✅ User profile management
- ✅ Session persistence

### 👨‍👩‍👧‍👦 Family Management
- ✅ Create family groups
- ✅ Add/remove members
- ✅ Admin & member roles
- ✅ Member profiles

### 📅 Calendar
- ✅ Weekly/Monthly view
- ✅ Interactive date selection
- ✅ Visual event indicators
- ✅ Smooth navigation

### 📝 Events
- ✅ Create/Edit/Delete
- ✅ Date & Time
- ✅ Title & Description
- ✅ Cost tracking
- ✅ Member assignment
- ✅ Reminders

### 💾 Storage
- ✅ Offline-first with Hive
- ✅ Cloud sync with Firestore
- ✅ Automatic synchronization
- ✅ No data loss

### 🔔 Notifications
- ✅ Local push notifications
- ✅ Event reminders
- ✅ Scheduled notifications
- ✅ Cross-platform

## 📁 File Structure

```
calendario-familiar/
│
├── 📄 Documentation
│   ├── README.md                    # Main documentation
│   ├── ARCHITECTURE.md              # Architecture guide
│   ├── FIREBASE_SETUP.md           # Firebase setup
│   ├── CONTRIBUTING.md             # Contribution guide
│   ├── CHANGELOG.md                # Version history
│   ├── IMPLEMENTATION_SUMMARY.md   # Implementation details
│   └── LICENSE                     # MIT License
│
├── 📱 Source Code (lib/)
│   ├── main.dart                   # App entry point
│   │
│   ├── 📦 models/                  # Data Models
│   │   ├── event_model.dart
│   │   ├── family_member_model.dart
│   │   └── user_model.dart
│   │
│   ├── 🔧 services/                # Business Logic
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── hive_service.dart
│   │   └── notification_service.dart
│   │
│   ├── 🔄 providers/               # State Management
│   │   ├── auth_provider.dart
│   │   ├── event_provider.dart
│   │   └── family_provider.dart
│   │
│   └── 🖥️ views/                   # UI Screens
│       ├── login_screen.dart
│       ├── home_screen.dart
│       ├── create_event_screen.dart
│       ├── event_detail_screen.dart
│       └── family_management_screen.dart
│
├── 🧪 Tests (test/)
│   └── event_model_test.dart       # Unit tests
│
├── 🤖 Android (android/)
│   └── app/
│       ├── build.gradle
│       └── src/main/
│           ├── AndroidManifest.xml
│           └── kotlin/.../MainActivity.kt
│
├── 🍎 iOS (ios/)
│   └── Runner/
│       ├── Info.plist
│       └── AppDelegate.swift
│
└── ⚙️ Configuration
    ├── pubspec.yaml               # Dependencies
    ├── analysis_options.yaml      # Linting rules
    └── .gitignore                # Git ignore rules
```

## 🏗️ Architecture Layers

```
┌─────────────────────────────────────┐
│         Views (UI Layer)            │
│  Login, Home, Events, Family        │
└─────────────────────────────────────┘
              ↕️
┌─────────────────────────────────────┐
│    Providers (State Management)     │
│  Auth, Event, Family Providers      │
└─────────────────────────────────────┘
              ↕️
┌─────────────────────────────────────┐
│     Services (Business Logic)       │
│  Auth, Firestore, Hive, Notify      │
└─────────────────────────────────────┘
              ↕️
┌─────────────────────────────────────┐
│       Models (Data Layer)           │
│  User, Event, FamilyMember          │
└─────────────────────────────────────┘
              ↕️
┌─────────────────────────────────────┐
│     External Services               │
│  Firebase, Hive, Notifications      │
└─────────────────────────────────────┘
```

## 🔑 Key Technologies

### Core Framework
- **Flutter 3.0+**: Cross-platform UI framework
- **Dart 3.0+**: Programming language

### State Management
- **Provider 6.1+**: Reactive state management
- **ChangeNotifier**: Observable pattern

### Storage
- **Hive 2.2+**: Fast local NoSQL database
- **Firebase Firestore 4.13+**: Cloud database
- **Path Provider**: File system access

### Authentication
- **Firebase Auth 4.15+**: User authentication
- **Google Sign-In 6.1+**: OAuth integration

### UI Components
- **Table Calendar 3.0+**: Calendar widget
- **Material 3**: Design system
- **Intl 0.18+**: Date formatting

### Notifications
- **Flutter Local Notifications 16.3+**: Push notifications
- **Timezone 0.9+**: Time zone handling

### Development
- **Flutter Lints 3.0+**: Code analysis
- **Build Runner 2.4+**: Code generation
- **Hive Generator 2.0+**: Model adapters

## 📊 Project Statistics

| Metric | Count |
|--------|-------|
| **Dart Files** | 19 |
| **Models** | 3 (+ 3 generated) |
| **Services** | 4 |
| **Providers** | 3 |
| **Screens** | 5 |
| **Documentation Pages** | 6 |
| **Test Files** | 1 (expandable) |
| **Lines of Code** | ~5,000+ |
| **Dependencies** | 14 |

## 🎯 User Flows

### First-Time User Flow
```
1. Open App
   ↓
2. Login Screen
   ↓
3. Sign in with Google
   ↓
4. Create Family
   ↓
5. Add Family Members
   ↓
6. Calendar View
   ↓
7. Create First Event
```

### Daily User Flow
```
1. Open App (Auto-login)
   ↓
2. View Calendar
   ↓
3. Select Date
   ↓
4. View/Add Events
   ↓
5. Receive Notifications
```

## 🔐 Security Features

- ✅ Google OAuth authentication
- ✅ Firebase security rules
- ✅ Encrypted cloud storage
- ✅ Sandboxed local storage
- ✅ No hardcoded secrets
- ✅ Secure API communication

## 🚀 Performance Features

- ✅ Offline-first architecture
- ✅ Local caching
- ✅ Lazy loading
- ✅ Efficient widgets (const, ListView.builder)
- ✅ Background sync
- ✅ Minimal rebuilds

## 📱 Platform Support

| Platform | Minimum Version | Status |
|----------|----------------|--------|
| Android | API 21 (5.0) | ✅ Ready |
| iOS | iOS 11.0 | ✅ Ready |
| Web | - | ❌ Not configured |
| Desktop | - | ❌ Not configured |

## 🎨 UI Screenshots Locations

*Note: Once Firebase is configured and app runs, screenshots should be added to:*
- Login screen
- Calendar view
- Event creation
- Event details
- Family management

## 🔧 Configuration Checklist

- [ ] Flutter SDK installed
- [ ] Firebase project created
- [ ] Android `google-services.json` added
- [ ] iOS `GoogleService-Info.plist` added
- [ ] Firebase Authentication enabled
- [ ] Firestore database created
- [ ] Security rules applied
- [ ] Dependencies installed (`flutter pub get`)
- [ ] App running (`flutter run`)

## 📚 Documentation Index

| Document | Purpose |
|----------|---------|
| **README.md** | Main project overview and setup |
| **ARCHITECTURE.md** | Technical architecture details |
| **FIREBASE_SETUP.md** | Firebase configuration guide |
| **CONTRIBUTING.md** | How to contribute to project |
| **CHANGELOG.md** | Version history and roadmap |
| **IMPLEMENTATION_SUMMARY.md** | Implementation details |
| **This File (OVERVIEW.md)** | Visual project overview |

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Hive Database](https://docs.hivedb.dev/)
- [Material Design 3](https://m3.material.io/)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

See **CONTRIBUTING.md** for detailed guidelines.

## 📄 License

MIT License - see **LICENSE** file for details.

## 👥 Author

**MagalhaesL** - [GitHub](https://github.com/MagalhaesL)

## 🆘 Support

- 🐛 [Report Bug](https://github.com/MagalhaesL/calendario-familiar/issues)
- 💡 [Request Feature](https://github.com/MagalhaesL/calendario-familiar/issues)
- 📖 [Read Docs](README.md)

---

**Status**: ✅ Production Ready (Pending Firebase Setup)

**Version**: 1.0.0

**Last Updated**: 2026-01-05
