# Architecture Documentation

## Overview

Calendário Familiar follows a clean, modular architecture pattern with clear separation of concerns. The app uses the Provider pattern for state management and implements offline-first functionality with Hive and Firebase Firestore synchronization.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                         Presentation Layer                   │
│                           (Views)                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Login Screen │  │ Home Screen  │  │ Event Screen │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    State Management Layer                     │
│                        (Providers)                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ AuthProvider │  │EventProvider │  │FamilyProvider│     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                       Business Logic Layer                   │
│                          (Services)                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Auth Service │  │Firestore Svc │  │  Hive Service│     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│  ┌──────────────────────────────────────────────────┐      │
│  │         Notification Service                      │      │
│  └──────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                         Data Layer                           │
│                         (Models)                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  User Model  │  │ Event Model  │  │ Member Model │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    External Services                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Firebase   │  │     Hive     │  │ Local Notif. │     │
│  │ (Cloud/Auth) │  │ (Local DB)   │  │   Service    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Layer Breakdown

### 1. Presentation Layer (Views)

**Location:** `lib/views/`

Responsible for UI rendering and user interaction.

- **LoginScreen**: Google Sign-In interface
- **HomeScreen**: Calendar view with event list
- **CreateEventScreen**: Form to create new events
- **EventDetailScreen**: Detailed view of an event
- **FamilyManagementScreen**: Family member management

**Responsibilities:**
- Display data from providers
- Capture user input
- Navigate between screens
- Show loading states and errors

**Dependencies:** Providers (via Consumer/Provider.of)

### 2. State Management Layer (Providers)

**Location:** `lib/providers/`

Implements business logic and manages app state using the Provider pattern.

#### AuthProvider
- Manages authentication state
- Handles Google Sign-In flow
- Maintains current user information
- Updates user family association

#### EventProvider
- Manages event CRUD operations
- Handles offline/online synchronization
- Schedules notifications
- Filters events by date/week

#### FamilyProvider
- Manages family creation and updates
- Handles family member operations
- Syncs family data with Firestore

**Responsibilities:**
- Expose state to UI
- Implement business logic
- Coordinate between services
- Notify listeners of state changes

**Dependencies:** Services, Models

### 3. Business Logic Layer (Services)

**Location:** `lib/services/`

Encapsulates external service interactions and complex operations.

#### AuthService
- Firebase Authentication integration
- Google Sign-In implementation
- User session management

#### FirestoreService
- Firebase Firestore operations
- CRUD operations for users, families, events
- Real-time data streaming
- Query operations

#### HiveService
- Local database operations
- Offline data storage
- Data retrieval and caching
- Hive box management

#### NotificationService
- Local notification scheduling
- Notification permission handling
- Event reminder management

**Responsibilities:**
- Abstract external dependencies
- Implement service-specific logic
- Handle errors and edge cases
- Provide clean APIs to providers

**Dependencies:** External packages (Firebase, Hive, etc.)

### 4. Data Layer (Models)

**Location:** `lib/models/`

Defines data structures and conversion methods.

#### User
- User profile information
- Family association
- Serialization methods

#### Event
- Event details and metadata
- Family member associations
- Cost tracking
- Reminder settings
- Hive and Firestore serialization

#### FamilyMember
- Member profile information
- Role (admin/member)
- Timestamp data

**Responsibilities:**
- Define data structures
- Implement serialization (toMap/fromMap)
- Support Hive storage (@HiveType)
- Provide copyWith methods for immutability

**Dependencies:** Hive (for annotations)

## Data Flow

### 1. User Action Flow

```
User Interaction → View → Provider → Service → External API
                                              ↓
User Interface  ← View ← Provider ← Service ← Response
```

### 2. Offline-First Flow

```
Create Event → EventProvider → HiveService (Save Locally)
                             → NotificationService (Schedule)
                             → FirestoreService (Sync if online)
```

### 3. Real-time Sync Flow

```
Firestore Changes → Stream → FirestoreService → Provider
                                                   ↓
                                               HiveService (Cache)
                                                   ↓
                                               notifyListeners()
                                                   ↓
                                                  View Updates
```

## Design Patterns

### 1. Repository Pattern
- Services act as repositories
- Abstract data sources (Firestore, Hive)
- Provide unified interface to providers

### 2. Provider Pattern
- State management using ChangeNotifier
- Dependency injection via Provider package
- Reactive UI updates

### 3. Singleton Pattern
- Service instances shared across app
- Hive boxes opened once
- Firebase initialized once

### 4. Factory Pattern
- Model fromMap constructors
- Create instances from different sources

## Key Principles

### 1. Separation of Concerns
- Each layer has specific responsibilities
- Clear boundaries between layers
- Minimal coupling

### 2. Dependency Inversion
- High-level modules don't depend on low-level modules
- Both depend on abstractions (interfaces)
- Services provide abstractions

### 3. Single Responsibility
- Each class has one reason to change
- Focused functionality
- Easy to test and maintain

### 4. DRY (Don't Repeat Yourself)
- Reusable services
- Shared models
- Common widgets

## State Management Details

### Provider Setup (main.dart)

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider(...)),
    ChangeNotifierProxyProvider<AuthProvider, EventProvider>(...),
    ChangeNotifierProxyProvider<AuthProvider, FamilyProvider>(...),
  ],
  child: MaterialApp(...),
)
```

### Provider Usage in Views

```dart
// Read data
final events = Provider.of<EventProvider>(context).events;

// Trigger actions
Provider.of<EventProvider>(context, listen: false).addEvent(event);

// React to changes
Consumer<EventProvider>(
  builder: (context, provider, child) {
    return ListView(children: provider.events.map(...).toList());
  },
)
```

## Offline-First Strategy

### Write Flow
1. Write to local Hive database (fast)
2. Update UI immediately
3. Sync to Firestore in background
4. Handle conflicts if necessary

### Read Flow
1. Read from local Hive database (instant)
2. Display data immediately
3. Listen to Firestore stream
4. Update when new data arrives

### Benefits
- Fast UI response
- Works without internet
- Seamless sync when online
- Better user experience

## Security Considerations

### Authentication
- Google Sign-In for user verification
- Firebase Authentication for session management
- Token-based authentication

### Authorization
- Firestore security rules
- Family-based access control
- Admin vs member permissions

### Data Protection
- Sensitive data in Firestore (encrypted in transit)
- Local data in Hive (app sandbox)
- No plaintext passwords

## Performance Optimizations

### 1. Lazy Loading
- Load data as needed
- Paginate large lists
- Stream data from Firestore

### 2. Caching
- Hive for local caching
- Reduce Firestore reads
- Offline support

### 3. Efficient Rendering
- Use const constructors
- Avoid unnecessary rebuilds
- ListView.builder for long lists

### 4. Background Sync
- Non-blocking operations
- Async/await patterns
- Stream subscriptions

## Testing Strategy

### Unit Tests
- Test models (serialization, copyWith)
- Test service methods
- Test provider logic

### Widget Tests
- Test individual screens
- Test user interactions
- Test state changes

### Integration Tests
- Test complete user flows
- Test offline/online scenarios
- Test Firebase integration

## Scalability Considerations

### 1. Modular Structure
- Easy to add new features
- Independent module development
- Clear interfaces

### 2. Service Abstraction
- Easy to swap implementations
- Mock services for testing
- Add new data sources

### 3. State Management
- Provider scales well
- Easy to add new providers
- Centralized state

### 4. Code Organization
- Logical file structure
- Feature-based organization possible
- Clear naming conventions

## Future Enhancements

### Potential Improvements
1. **Feature Modules**: Group related files by feature
2. **Use Cases/Interactors**: Add layer between providers and services
3. **Repository Interfaces**: Define contracts for services
4. **Dependency Injection**: Use get_it or similar for DI
5. **BLoC Pattern**: Consider for complex state management
6. **GraphQL**: Alternative to Firestore for better queries
7. **Background Sync**: Service workers for background synchronization

## Resources

- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Provider Package Documentation](https://pub.dev/packages/provider)
- [Firebase Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [Hive Documentation](https://docs.hivedb.dev/)
