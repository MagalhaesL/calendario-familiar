import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/event_model.dart';
import '../services/firestore_service.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';
import '../main.dart';

class EventProvider with ChangeNotifier {
  final FirestoreService firestoreService;
  final HiveService hiveService;
  
  List<Event> _events = [];
  String? _userId;
  String? _familyId;
  bool _isLoading = false;
  String? _errorMessage;

  EventProvider({
    required this.firestoreService,
    required this.hiveService,
  }) {
    _loadLocalEvents();
  }

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateUser(String? userId) {
    _userId = userId;
    if (userId != null) {
      _loadLocalEvents();
    }
  }

  void updateFamilyId(String? familyId) {
    _familyId = familyId;
    if (familyId != null) {
      _syncWithFirestore();
    }
  }

  void _loadLocalEvents() {
    _events = hiveService.getEvents();
    notifyListeners();
  }

  Future<void> _syncWithFirestore() async {
    if (_familyId == null) return;

    try {
      firestoreService.getEvents(_familyId!).listen((firestoreEvents) {
        // Save to local storage
        hiveService.saveEvents(firestoreEvents);
        _events = firestoreEvents;
        notifyListeners();
      });
    } catch (e) {
      print('Error syncing with Firestore: $e');
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Save locally first
      await hiveService.saveEvent(event);
      _events.add(event);
      _events.sort((a, b) => a.date.compareTo(b.date));

      // Schedule notification if reminder is set
      if (event.reminderTime != null) {
        await NotificationService.scheduleEventReminder(
          flutterLocalNotificationsPlugin,
          event,
        );
      }

      // Sync with Firestore if online and family exists
      if (_familyId != null) {
        await firestoreService.createEvent(_familyId!, event);
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

  Future<void> updateEvent(Event event) async {
    try {
      _isLoading = true;
      notifyListeners();

      final updatedEvent = event.copyWith(updatedAt: DateTime.now());

      // Update locally
      await hiveService.saveEvent(updatedEvent);
      final index = _events.indexWhere((e) => e.id == updatedEvent.id);
      if (index != -1) {
        _events[index] = updatedEvent;
        _events.sort((a, b) => a.date.compareTo(b.date));
      }

      // Update notification
      await NotificationService.cancelEventReminder(
        flutterLocalNotificationsPlugin,
        updatedEvent.id,
      );
      if (updatedEvent.reminderTime != null) {
        await NotificationService.scheduleEventReminder(
          flutterLocalNotificationsPlugin,
          updatedEvent,
        );
      }

      // Sync with Firestore if online and family exists
      if (_familyId != null) {
        await firestoreService.updateEvent(_familyId!, updatedEvent);
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

  Future<void> deleteEvent(String eventId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Delete locally
      await hiveService.deleteEvent(eventId);
      _events.removeWhere((e) => e.id == eventId);

      // Cancel notification
      await NotificationService.cancelEventReminder(
        flutterLocalNotificationsPlugin,
        eventId,
      );

      // Sync with Firestore if online and family exists
      if (_familyId != null) {
        await firestoreService.deleteEvent(_familyId!, eventId);
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

  List<Event> getEventsByDate(DateTime date) {
    return _events.where((event) {
      return event.date.year == date.year &&
          event.date.month == date.month &&
          event.date.day == date.day;
    }).toList();
  }

  List<Event> getEventsForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return hiveService.getEventsByDateRange(weekStart, weekEnd);
  }

  Event createNewEvent({
    required String title,
    String? description,
    required DateTime date,
    required List<String> involvedMembers,
    double? cost,
    DateTime? reminderTime,
  }) {
    if (_userId == null) {
      throw Exception('User not logged in');
    }

    return Event(
      id: const Uuid().v4(),
      title: title,
      description: description,
      date: date,
      involvedMembers: involvedMembers,
      cost: cost,
      reminderTime: reminderTime,
      createdBy: _userId!,
      createdAt: DateTime.now(),
    );
  }
}
