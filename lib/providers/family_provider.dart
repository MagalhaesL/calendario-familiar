import 'package:flutter/foundation.dart';
import '../models/family_member_model.dart';
import '../services/firestore_service.dart';
import '../services/hive_service.dart';

class FamilyProvider with ChangeNotifier {
  final FirestoreService firestoreService;
  final HiveService hiveService;
  
  List<FamilyMember> _members = [];
  String? _userId;
  String? _familyId;
  bool _isLoading = false;
  String? _errorMessage;

  FamilyProvider({
    required this.firestoreService,
    required this.hiveService,
  }) {
    _loadLocalMembers();
  }

  List<FamilyMember> get members => _members;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get familyId => _familyId;

  void updateUser(String? userId) {
    _userId = userId;
    if (userId != null) {
      _loadLocalMembers();
    }
  }

  void updateFamilyId(String? familyId) {
    _familyId = familyId;
    if (familyId != null) {
      _syncWithFirestore();
    }
  }

  void _loadLocalMembers() {
    _members = hiveService.getFamilyMembers();
    notifyListeners();
  }

  Future<void> _syncWithFirestore() async {
    if (_familyId == null) return;

    try {
      firestoreService.getFamilyMembers(_familyId!).listen((firestoreMembers) {
        // Save to local storage
        hiveService.saveFamilyMembers(firestoreMembers);
        _members = firestoreMembers;
        notifyListeners();
      });
    } catch (e) {
      // Sync errors are logged but don't block offline functionality
      _errorMessage = 'Sync error: ${e.toString()}';
    }
  }

  Future<String> createFamily(String familyName) async {
    if (_userId == null) {
      throw Exception('User not logged in');
    }

    try {
      _isLoading = true;
      notifyListeners();

      final familyId = await firestoreService.createFamily(_userId!, familyName);
      _familyId = familyId;
      
      _isLoading = false;
      notifyListeners();
      
      return familyId;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addMember(FamilyMember member) async {
    if (_familyId == null) {
      throw Exception('No family created yet');
    }

    try {
      _isLoading = true;
      notifyListeners();

      // Save locally first
      await hiveService.saveFamilyMember(member);
      _members.add(member);

      // Sync with Firestore if online
      await firestoreService.addFamilyMember(_familyId!, member);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeMember(String memberId) async {
    if (_familyId == null) {
      throw Exception('No family created yet');
    }

    try {
      _isLoading = true;
      notifyListeners();

      // Delete locally
      await hiveService.deleteFamilyMember(memberId);
      _members.removeWhere((m) => m.id == memberId);

      // Sync with Firestore if online
      await firestoreService.removeFamilyMember(_familyId!, memberId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  FamilyMember? getMemberById(String id) {
    try {
      return _members.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }
}
