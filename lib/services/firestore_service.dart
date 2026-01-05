import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import '../models/family_member_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<User?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Family operations
  Future<String> createFamily(String userId, String familyName) async {
    final familyDoc = await _firestore.collection('families').add({
      'name': familyName,
      'adminId': userId,
      'createdAt': DateTime.now().toIso8601String(),
    });
    
    // Update user with familyId
    await _firestore.collection('users').doc(userId).update({
      'familyId': familyDoc.id,
    });
    
    return familyDoc.id;
  }

  Future<void> addFamilyMember(String familyId, FamilyMember member) async {
    await _firestore
        .collection('families')
        .doc(familyId)
        .collection('members')
        .doc(member.id)
        .set(member.toMap());
  }

  Stream<List<FamilyMember>> getFamilyMembers(String familyId) {
    return _firestore
        .collection('families')
        .doc(familyId)
        .collection('members')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FamilyMember.fromMap(doc.data()))
            .toList());
  }

  Future<void> removeFamilyMember(String familyId, String memberId) async {
    await _firestore
        .collection('families')
        .doc(familyId)
        .collection('members')
        .doc(memberId)
        .delete();
  }

  // Event operations
  Future<void> createEvent(String familyId, Event event) async {
    await _firestore
        .collection('families')
        .doc(familyId)
        .collection('events')
        .doc(event.id)
        .set(event.toMap());
  }

  Future<void> updateEvent(String familyId, Event event) async {
    await _firestore
        .collection('families')
        .doc(familyId)
        .collection('events')
        .doc(event.id)
        .update(event.toMap());
  }

  Future<void> deleteEvent(String familyId, String eventId) async {
    await _firestore
        .collection('families')
        .doc(familyId)
        .collection('events')
        .doc(eventId)
        .delete();
  }

  Stream<List<Event>> getEvents(String familyId) {
    return _firestore
        .collection('families')
        .doc(familyId)
        .collection('events')
        .orderBy('date')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList());
  }

  Stream<List<Event>> getEventsByDateRange(
    String familyId,
    DateTime start,
    DateTime end,
  ) {
    return _firestore
        .collection('families')
        .doc(familyId)
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('date', isLessThanOrEqualTo: end.toIso8601String())
        .orderBy('date')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList());
  }
}
