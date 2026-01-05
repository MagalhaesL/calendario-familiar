import 'package:hive/hive.dart';

part 'family_member_model.g.dart';

@HiveType(typeId: 1)
class FamilyMember {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? photoUrl;

  @HiveField(4)
  final String role; // 'admin' or 'member'

  @HiveField(5)
  final DateTime addedAt;

  FamilyMember({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    required this.addedAt,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  // Create from Firestore Map
  factory FamilyMember.fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
      role: map['role'] as String,
      addedAt: DateTime.parse(map['addedAt'] as String),
    );
  }

  FamilyMember copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? role,
    DateTime? addedAt,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
