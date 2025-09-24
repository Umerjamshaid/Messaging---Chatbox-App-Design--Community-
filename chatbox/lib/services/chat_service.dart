import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user chats
  Stream<List<ChatModel>> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('members', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatModel.fromMap(doc.data()))
              .toList();
        });
  }

  // Create new chat
  Future<String> createChat(ChatModel chat) async {
    DocumentReference docRef = await _firestore
        .collection('chats')
        .add(chat.toMap());
    return docRef.id;
  }

  // Get chat by ID
  Future<ChatModel?> getChatById(String chatId) async {
    DocumentSnapshot doc = await _firestore
        .collection('chats')
        .doc(chatId)
        .get();
    if (doc.exists) {
      return ChatModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Send message
  Future<void> sendMessage(MessageModel message) async {
    // Add message to subcollection
    await _firestore
        .collection('chats')
        .doc(message.chatId)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());

    // Update chat metadata
    await _firestore.collection('chats').doc(message.chatId).update({
      'lastMessage': message.text,
      'lastMessageSender': message.senderId,
      'lastMessageTime': message.timestamp,
    });
  }

  // Get messages for chat with pagination
  Stream<List<MessageModel>> getMessages(String chatId, {int limit = 20}) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();
        });
  }

  // Load more messages (pagination)
  Future<List<MessageModel>> loadMoreMessages(
    String chatId,
    DateTime lastMessageTime, {
    int limit = 20,
  }) async {
    QuerySnapshot snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .startAfter([lastMessageTime])
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Update message status
  Future<void> updateMessageStatus(
    String chatId,
    String messageId,
    MessageStatus status,
  ) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({'status': status.index});
  }

  // Update typing indicator
  Future<void> updateTypingStatus(
    String chatId,
    String userId,
    bool isTyping,
  ) async {
    await _firestore.collection('chats').doc(chatId).update({
      'typingUsers.$userId': isTyping,
    });
  }

  // Search users
  Future<List<UserModel>> searchUsers(String query, {int limit = 10}) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Add member to group chat
  Future<void> addMemberToChat(
    String chatId,
    String userId,
    String role,
  ) async {
    await _firestore.collection('chats').doc(chatId).update({
      'members': FieldValue.arrayUnion([userId]),
      'roles.$userId': role,
    });
  }

  // Remove member from group chat
  Future<void> removeMemberFromChat(String chatId, String userId) async {
    await _firestore.collection('chats').doc(chatId).update({
      'members': FieldValue.arrayRemove([userId]),
      'roles.$userId': FieldValue.delete(),
    });
  }

  // Update chat info
  Future<void> updateChatInfo(
    String chatId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore.collection('chats').doc(chatId).update(updates);
  }

  // Delete message
  Future<void> deleteMessage(String chatId, String messageId) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  // Get chat members
  Future<List<UserModel>> getChatMembers(List<String> memberIds) async {
    if (memberIds.isEmpty) return [];

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: memberIds)
        .get();

    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
