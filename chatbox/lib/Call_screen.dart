import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallScreen extends StatelessWidget {
  final String name;
  final String avatar;

  const CallScreen({Key? key, required this.name, required this.avatar})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar
          CircleAvatar(backgroundImage: AssetImage(avatar), radius: 80),
          SizedBox(height: 20),
          // Name
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Call status
          Text(
            "Calling...",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 50),
          // Call controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mute button
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.mic_off, color: Colors.white, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text("Mute", style: TextStyle(color: Colors.white)),
                ],
              ),
              // Speaker button
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                    child: Icon(Icons.volume_up, color: Colors.white, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text("Speaker", style: TextStyle(color: Colors.white)),
                ],
              ),
              // Hang up button
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(Icons.call_end, color: Colors.white, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text("Hang Up", style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
