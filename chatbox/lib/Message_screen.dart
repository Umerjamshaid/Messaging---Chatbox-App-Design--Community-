import 'package:chatbox/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const MessageScreen({Key? key, required this.name, required this.avatar})
    : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(MessageProvider mp) {
    if (_controller.text.isNotEmpty) {
      mp.addMessage(_controller.text, true);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    String chatId = 'chat_${widget.name.replaceAll(' ', '_')}';
    return ChangeNotifierProvider(
      create: (_) {
        var provider = MessageProvider();
        provider.setChatId(chatId);
        return provider;
      },
      child: Consumer<MessageProvider>(
        builder: (context, messageProvider, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.avatar),
                        radius: 20,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Active now",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/m-Call.svg',
                          width: 24,
                          height: 24,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/images/Video.svg'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: messageProvider.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF8FBFA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                      Message message = messageProvider.messages[index - 1];
                      if (message.isMine) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13),
                                bottomLeft: Radius.circular(13),
                                bottomRight: Radius.circular(13),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(widget.avatar),
                                radius: 18,
                              ),
                              SizedBox(width: 8),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                          bottomRight: Radius.circular(13),
                                        ),
                                      ),
                                      child: Text(message.text),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  height: 90,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.attach_file, color: Colors.black, size: 24),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Write your message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) =>
                                      _sendMessage(messageProvider),
                                ),
                              ),
                              Icon(
                                Icons.content_paste_rounded,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.teal, size: 24),
                        onPressed: () => _sendMessage(messageProvider),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
