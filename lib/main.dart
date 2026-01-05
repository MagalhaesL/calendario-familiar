import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/hive_service.dart';
import 'services/notification_service.dart';
import 'providers/auth_provider.dart';
import 'providers/event_provider.dart';
import 'providers/family_provider.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Hive
  await Hive.initFlutter();
  await HiveService.init();
  
  // Initialize Timezone for notifications
  tz.initializeTimeZones();
  
  // Initialize Notifications
  await NotificationService.initialize(flutterLocalNotificationsPlugin);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            authService: AuthService(),
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, EventProvider>(
          create: (_) => EventProvider(
            firestoreService: FirestoreService(),
            hiveService: HiveService(),
          ),
          update: (_, auth, previous) {
            if (previous != null) {
              previous.updateUser(auth.user?.uid);
              return previous;
            }
            return EventProvider(
              firestoreService: FirestoreService(),
              hiveService: HiveService(),
            )..updateUser(auth.user?.uid);
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, FamilyProvider>(
          create: (_) => FamilyProvider(
            firestoreService: FirestoreService(),
            hiveService: HiveService(),
          ),
          update: (_, auth, previous) {
            if (previous != null) {
              previous.updateUser(auth.user?.uid);
              return previous;
            }
            return FamilyProvider(
              firestoreService: FirestoreService(),
              hiveService: HiveService(),
            )..updateUser(auth.user?.uid);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Calendário Familiar',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (authProvider.user != null) {
      return const HomeScreen();
    }
    
    return const LoginScreen();
  }
}
