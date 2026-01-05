# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-05

### Added
- Initial release of Calendário Familiar
- Google Sign-In authentication
- Family structure creation and management
- Family member addition and removal
- Weekly calendar view with month/week toggle
- Event creation with full details (title, description, date, time, cost, members, reminders)
- Event editing and deletion
- Offline storage with Hive
- Online synchronization with Firebase Firestore
- Local push notifications for event reminders
- User profile display
- Modular architecture with clear separation of concerns
- Comprehensive documentation (README, FIREBASE_SETUP, CONTRIBUTING, ARCHITECTURE)
- Unit tests for models
- Android and iOS support

### Features in Detail

#### Authentication
- Seamless Google Sign-In integration
- Automatic user profile creation
- Persistent login sessions
- Secure authentication via Firebase

#### Family Management
- Create family groups
- Add family members with name and email
- Admin and member roles
- Remove non-admin members
- View all family members

#### Calendar
- Interactive weekly/monthly calendar view
- Visual indicators for days with events
- Day selection to view events
- Smooth navigation between weeks/months

#### Events
- Create events with rich details
- Set date and time
- Add optional description
- Track costs/expenses
- Select involved family members
- Set reminder notifications
- View event details
- Delete events with confirmation

#### Offline/Online
- Automatic offline storage
- Works without internet connection
- Background synchronization when online
- No data loss
- Seamless user experience

#### Notifications
- Schedule reminders for events
- Local push notifications
- Customizable reminder times
- Automatic notification management

### Technical
- Flutter SDK 3.0+
- Provider state management
- Hive for local storage
- Firebase Authentication
- Firebase Firestore
- Local notifications
- Material Design 3
- Clean architecture
- Type-safe models
- Error handling
- Loading states

### Documentation
- Comprehensive README
- Firebase setup guide
- Contributing guidelines
- Architecture documentation
- Inline code comments
- Example tests

### Platform Support
- Android (API 21+)
- iOS (iOS 11+)

## [Unreleased]

### Planned Features
- Event categories/tags
- Recurring events
- Expense reports and analytics
- Multiple calendars per family
- Color coding for events
- Event attachments (photos, documents)
- Family chat/messaging
- Push notifications for family updates
- Calendar export (iCal format)
- Dark mode
- Localization (PT-BR, EN, ES)
- Widget for home screen
- Integration with Google Calendar
- Biometric authentication
- Profile pictures
- Family activity feed

### Under Consideration
- Budget tracking and limits
- Shopping lists
- Task assignments
- Location-based reminders
- Voice input for events
- AI-powered scheduling suggestions
