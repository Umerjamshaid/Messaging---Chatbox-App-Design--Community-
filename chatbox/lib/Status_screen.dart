import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Status'), backgroundColor: Colors.black),
      body: Column(
        children: [
          // My Status
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/images/profile-image.png')
                            as ImageProvider,
                  radius: 25,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.add, color: Colors.white, size: 15),
                  ),
                ),
              ],
            ),
            title: Text('My Status'),
            subtitle: Text('Tap to add status'),
            onTap: _pickImage,
          ),
          Divider(),
          // Recent Updates
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('online', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final users = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/profile-image.png',
                        ), // Default avatar
                        radius: 25,
                      ),
                      title: Text(user['email'] ?? 'User'),
                      subtitle: Text('Online'),
                      onTap: () {
                        // Navigate to status view
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
