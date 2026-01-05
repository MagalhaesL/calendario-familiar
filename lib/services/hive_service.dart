import 'package:hive_flutter/hive_flutter.dart';
import '../models/event_model.dart';
import '../models/family_member_model.dart';
import '../models/user_model.dart';

class HiveService {
  static const String eventsBox = 'events';
  static const String familyMembersBox = 'family_members';
  static const String userBox = 'user';

  static Future<void> init() async {
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EventAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FamilyMemberAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserAdapter());
    }

    // Open boxes
    await Hive.openBox<Event>(eventsBox);
    await Hive.openBox<FamilyMember>(familyMembersBox);
    await Hive.openBox<User>(userBox);
  }

  // Event operations
  Future<void> saveEvent(Event event) async {
    final box = Hive.box<Event>(eventsBox);
    await box.put(event.id, event);
  }

  Future<void> saveEvents(List<Event> events) async {
    final box = Hive.box<Event>(eventsBox);
    for (var event in events) {
      await box.put(event.id, event);
    }
  }

  List<Event> getEvents() {
    final box = Hive.box<Event>(eventsBox);
    return box.values.toList();
  }

  Event? getEvent(String id) {
    final box = Hive.box<Event>(eventsBox);
    return box.get(id);
  }

  Future<void> deleteEvent(String id) async {
    final box = Hive.box<Event>(eventsBox);
    await box.delete(id);
  }

  List<Event> getEventsByDateRange(DateTime start, DateTime end) {
    final box = Hive.box<Event>(eventsBox);
    return box.values
        .where((event) =>
            event.date.isAfter(start.subtract(const Duration(days: 1))) &&
            event.date.isBefore(end.add(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Family member operations
  Future<void> saveFamilyMember(FamilyMember member) async {
    final box = Hive.box<FamilyMember>(familyMembersBox);
    await box.put(member.id, member);
  }

  Future<void> saveFamilyMembers(List<FamilyMember> members) async {
    final box = Hive.box<FamilyMember>(familyMembersBox);
    for (var member in members) {
      await box.put(member.id, member);
    }
  }

  List<FamilyMember> getFamilyMembers() {
    final box = Hive.box<FamilyMember>(familyMembersBox);
    return box.values.toList();
  }

  FamilyMember? getFamilyMember(String id) {
    final box = Hive.box<FamilyMember>(familyMembersBox);
    return box.get(id);
  }

  Future<void> deleteFamilyMember(String id) async {
    final box = Hive.box<FamilyMember>(familyMembersBox);
    await box.delete(id);
  }

  // User operations
  Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBox);
    await box.put('current_user', user);
  }

  User? getCurrentUser() {
    final box = Hive.box<User>(userBox);
    return box.get('current_user');
  }

  Future<void> clearCurrentUser() async {
    final box = Hive.box<User>(userBox);
    await box.delete('current_user');
  }

  // Clear all data
  Future<void> clearAllData() async {
    await Hive.box<Event>(eventsBox).clear();
    await Hive.box<FamilyMember>(familyMembersBox).clear();
    await Hive.box<User>(userBox).clear();
  }
}
