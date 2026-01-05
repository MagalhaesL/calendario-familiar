import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;
  final FirestoreService _firestoreService = FirestoreService();
  
  User? _user;
  bool _isLoading = true;
  String? _errorMessage;

  AuthProvider({required this.authService}) {
    _init();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _init() {
    authService.authStateChanges.listen((firebase_auth.User? firebaseUser) async {
      if (firebaseUser != null) {
        // Get user data from Firestore
        User? user = await _firestoreService.getUser(firebaseUser.uid);
        
        if (user == null) {
          // Create new user in Firestore
          user = User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            displayName: firebaseUser.displayName ?? '',
            photoUrl: firebaseUser.photoURL,
            createdAt: DateTime.now(),
          );
          await _firestoreService.createUser(user);
        }
        
        _user = user;
      } else {
        _user = null;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();

      final user = await authService.signInWithGoogle();
      
      if (user != null) {
        _user = user;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateUserFamilyId(String familyId) async {
    if (_user != null) {
      _user = _user!.copyWith(familyId: familyId);
      await _firestoreService.updateUser(_user!);
      notifyListeners();
    }
  }
}
