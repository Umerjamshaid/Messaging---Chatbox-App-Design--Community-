import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String status;
  final DateTime lastSeen;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.status,
    required this.lastSeen,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'status': status,
      'lastSeen': lastSeen.toIso8601String(),
    };
  }

  // Create from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photo: map['photo'] ?? '',
      status: map['status'] ?? 'offline',
      lastSeen: map['lastSeen'] != null
          ? DateTime.parse(map['lastSeen'])
          : DateTime.now(),
    );
  }

  // Create from Firestore document snapshot
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  // Copy with method for updates
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photo,
    String? status,
    DateTime? lastSeen,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.photo == photo &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        photo.hashCode ^
        status.hashCode;
  }
}
