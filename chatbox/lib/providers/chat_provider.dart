import 'package:flutter/foundation.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../services/chat_service.dart';
import '../services/auth_service.dart';

class ChatProvider with ChangeNotifier {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _currentChatId;

  List<ChatModel> get chats => _chats;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get currentChatId => _currentChatId;

  // Load user chats
  void loadUserChats(String userId) {
    _chatService.getUserChats(userId).listen((chats) {
      _chats = chats;
      notifyListeners();
    });
  }

  // Load messages for a chat
  void loadMessages(String chatId) {
    _currentChatId = chatId;
    _chatService.getMessages(chatId).listen((messages) {
      _messages = messages.reversed.toList(); // Reverse to show oldest first
      notifyListeners();
    });
  }

  // Send message
  Future<void> sendMessage(
    String chatId,
    String text, {
    MessageType type = MessageType.text,
    String? mediaUrl,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      String? currentUserId = _authService.currentUser?.uid;
      if (currentUserId == null) return;

      MessageModel message = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: currentUserId,
        chatId: chatId,
        text: text,
        type: type,
        mediaUrl: mediaUrl,
        timestamp: DateTime.now(),
        status: MessageStatus.sending,
      );

      await _chatService.sendMessage(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create new chat
  Future<String?> createChat(
    String name,
    List<String> members, {
    ChatType type = ChatType.private,
  }) async {
    try {
      String? currentUserId = _authService.currentUser?.uid;
      if (currentUserId == null) return null;

      List<String> allMembers = [currentUserId, ...members];

      ChatModel chat = ChatModel(
        id: '', // Will be set by Firestore
        name: type == ChatType.private
            ? ''
            : name, // Private chats don't need names
        members: allMembers,
        createdAt: DateTime.now(),
        type: type,
      );

      String chatId = await _chatService.createChat(chat);
      return chatId;
    } catch (e) {
      debugPrint('Error creating chat: $e');
      return null;
    }
  }

  // Update typing status
  Future<void> updateTypingStatus(String chatId, bool isTyping) async {
    try {
      String? currentUserId = _authService.currentUser?.uid;
      if (currentUserId != null) {
        await _chatService.updateTypingStatus(chatId, currentUserId, isTyping);
      }
    } catch (e) {
      debugPrint('Error updating typing status: $e');
    }
  }

  // Search users
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      return await _chatService.searchUsers(query);
    } catch (e) {
      debugPrint('Error searching users: $e');
      return [];
    }
  }

  // Load more messages
  Future<void> loadMoreMessages() async {
    if (_messages.isEmpty || _currentChatId == null) return;

    try {
      List<MessageModel> olderMessages = await _chatService.loadMoreMessages(
        _currentChatId!,
        _messages.first.timestamp,
      );

      _messages.insertAll(0, olderMessages);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading more messages: $e');
    }
  }

  // Clear current chat
  void clearCurrentChat() {
    _currentChatId = null;
    _messages = [];
    notifyListeners();
  }
}
