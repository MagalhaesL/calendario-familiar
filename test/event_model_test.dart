import 'package:flutter_test/flutter_test.dart';
import 'package:calendario_familiar/models/event_model.dart';

void main() {
  group('Event Model Tests', () {
    test('Event model should be created correctly', () {
      final now = DateTime.now();
      final event = Event(
        id: '1',
        title: 'Test Event',
        description: 'Test Description',
        date: now,
        involvedMembers: ['user1', 'user2'],
        cost: 100.0,
        reminderTime: now.add(const Duration(hours: 1)),
        createdBy: 'user1',
        createdAt: now,
      );

      expect(event.id, '1');
      expect(event.title, 'Test Event');
      expect(event.description, 'Test Description');
      expect(event.date, now);
      expect(event.involvedMembers, ['user1', 'user2']);
      expect(event.cost, 100.0);
      expect(event.createdBy, 'user1');
      expect(event.createdAt, now);
    });

    test('Event should convert to map correctly', () {
      final now = DateTime.now();
      final event = Event(
        id: '1',
        title: 'Test Event',
        date: now,
        involvedMembers: ['user1'],
        createdBy: 'user1',
        createdAt: now,
      );

      final map = event.toMap();

      expect(map['id'], '1');
      expect(map['title'], 'Test Event');
      expect(map['date'], now.toIso8601String());
      expect(map['involvedMembers'], ['user1']);
      expect(map['createdBy'], 'user1');
    });

    test('Event should be created from map correctly', () {
      final now = DateTime.now();
      final map = {
        'id': '1',
        'title': 'Test Event',
        'description': 'Test Description',
        'date': now.toIso8601String(),
        'involvedMembers': ['user1', 'user2'],
        'cost': 100.0,
        'reminderTime': now.add(const Duration(hours: 1)).toIso8601String(),
        'createdBy': 'user1',
        'createdAt': now.toIso8601String(),
      };

      final event = Event.fromMap(map);

      expect(event.id, '1');
      expect(event.title, 'Test Event');
      expect(event.description, 'Test Description');
      expect(event.involvedMembers, ['user1', 'user2']);
      expect(event.cost, 100.0);
      expect(event.createdBy, 'user1');
    });

    test('Event copyWith should work correctly', () {
      final now = DateTime.now();
      final event = Event(
        id: '1',
        title: 'Test Event',
        date: now,
        involvedMembers: ['user1'],
        createdBy: 'user1',
        createdAt: now,
      );

      final updatedEvent = event.copyWith(
        title: 'Updated Event',
        cost: 50.0,
      );

      expect(updatedEvent.id, '1');
      expect(updatedEvent.title, 'Updated Event');
      expect(updatedEvent.cost, 50.0);
      expect(updatedEvent.createdBy, 'user1');
    });
  });
}
