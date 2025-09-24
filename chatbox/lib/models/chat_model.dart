import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatType { private, group }

class ChatModel {
  final String id;
  final String name;
  final String? description;
  final String? photo;
  final ChatType type;
  final List<String> members;
  final Map<String, String> roles; // userId -> role (admin, moderator, member)
  final String? lastMessage;
  final String? lastMessageSender;
  final DateTime? lastMessageTime;
  final DateTime createdAt;
  final Map<String, bool> typingUsers; // userId -> isTyping

  ChatModel({
    required this.id,
    required this.name,
    this.description,
    this.photo,
    this.type = ChatType.private,
    required this.members,
    this.roles = const {},
    this.lastMessage,
    this.lastMessageSender,
    this.lastMessageTime,
    required this.createdAt,
    this.typingUsers = const {},
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      photo: map['photo'],
      type: ChatType.values[map['type'] ?? 0],
      members: List<String>.from(map['members'] ?? []),
      roles: Map<String, String>.from(map['roles'] ?? {}),
      lastMessage: map['lastMessage'],
      lastMessageSender: map['lastMessageSender'],
      lastMessageTime: (map['lastMessageTime'] as Timestamp?)?.toDate(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      typingUsers: Map<String, bool>.from(map['typingUsers'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
      'type': type.index,
      'members': members,
      'roles': roles,
      'lastMessage': lastMessage,
      'lastMessageSender': lastMessageSender,
      'lastMessageTime': lastMessageTime != null
          ? Timestamp.fromDate(lastMessageTime!)
          : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'typingUsers': typingUsers,
    };
  }

  ChatModel copyWith({
    String? id,
    String? name,
    String? description,
    String? photo,
    ChatType? type,
    List<String>? members,
    Map<String, String>? roles,
    String? lastMessage,
    String? lastMessageSender,
    DateTime? lastMessageTime,
    DateTime? createdAt,
    Map<String, bool>? typingUsers,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      type: type ?? this.type,
      members: members ?? this.members,
      roles: roles ?? this.roles,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      createdAt: createdAt ?? this.createdAt,
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }

  bool isGroupChat() => type == ChatType.group;
  bool isPrivateChat() => type == ChatType.private;
}
