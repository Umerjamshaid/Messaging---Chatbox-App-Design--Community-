import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMine;
  final DateTime timestamp;
  final String id;

  Message({
    required this.text,
    required this.isMine,
    required this.timestamp,
    required this.id,
  });
}

class MessageProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String chatId = 'default_chat'; // e.g., 'chat_with_adil'
  StreamSubscription? _subscription;

  MessageProvider() {
    _listenToMessages();
  }

  void setChatId(String id) {
    chatId = id;
    _listenToMessages(); // Restart listener
  }

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void _listenToMessages() {
    _subscription?.cancel();
    _subscription = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
          _messages = snapshot.docs.map((doc) {
            var data = doc.data();
            return Message(
              text: data['text'],
              isMine: data['sender'] == 'me', // Assume 'me' for current user
              timestamp: (data['timestamp'] as Timestamp).toDate(),
              id: doc.id,
            );
          }).toList();
          notifyListeners();
        });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> addMessage(String text, bool isMine) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add(
      {
        'text': text,
        'sender': isMine ? 'me' : 'other',
        'timestamp': Timestamp.now(),
      },
    );
  }
}
