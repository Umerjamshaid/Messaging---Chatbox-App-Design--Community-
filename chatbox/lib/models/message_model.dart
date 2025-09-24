import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video, file, voice }

enum MessageStatus { sending, sent, delivered, read }

class MessageModel {
  final String id;
  final String senderId;
  final String chatId;
  final String text;
  final MessageType type;
  final String? mediaUrl;
  final DateTime timestamp;
  final MessageStatus status;
  final String? replyTo;
  final List<String>? reactions;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.chatId,
    required this.text,
    this.type = MessageType.text,
    this.mediaUrl,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.replyTo,
    this.reactions,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      chatId: map['chatId'] ?? '',
      text: map['text'] ?? '',
      type: MessageType.values[map['type'] ?? 0],
      mediaUrl: map['mediaUrl'],
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: MessageStatus.values[map['status'] ?? 1],
      replyTo: map['replyTo'],
      reactions: List<String>.from(map['reactions'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'chatId': chatId,
      'text': text,
      'type': type.index,
      'mediaUrl': mediaUrl,
      'timestamp': Timestamp.fromDate(timestamp),
      'status': status.index,
      'replyTo': replyTo,
      'reactions': reactions ?? [],
    };
  }

  MessageModel copyWith({
    String? id,
    String? senderId,
    String? chatId,
    String? text,
    MessageType? type,
    String? mediaUrl,
    DateTime? timestamp,
    MessageStatus? status,
    String? replyTo,
    List<String>? reactions,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      chatId: chatId ?? this.chatId,
      text: text ?? this.text,
      type: type ?? this.type,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      replyTo: replyTo ?? this.replyTo,
      reactions: reactions ?? this.reactions,
    );
  }
}
