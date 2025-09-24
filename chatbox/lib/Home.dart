import 'package:chatbox/Message_screen.dart';
import 'package:chatbox/Call_screen.dart';
import 'package:chatbox/Status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Search functionality
  void _searchChats(String query) {
    // TODO: Implement search
  }

  @override
  Widget build(BuildContext context) {
    Widget _getBody() {
      switch (_selectedIndex) {
        case 0:
          return _buildChatList();
        case 1:
          return _buildGroupsList();
        case 2:
          return _buildContactsList();
        case 3:
          return _buildProfileScreen();
        default:
          return _buildChatList();
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              title: Text('Chats', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    // TODO: Open search
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      // TODO: New chat
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // TODO: Settings
                    },
                  ),
                ),
              ],
            )
          : null,
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/message.svg',
              width: 24,
              height: 24,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Call.svg',
              width: 24,
              height: 24,
            ),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/user.svg',
              width: 24,
              height: 24,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/settings.svg',
              width: 24,
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // TODO: New conversation
              },
              backgroundColor: const Color(0xFF43116A),
              child: const Icon(Icons.message),
            )
          : null,
    );
  }

  Widget _buildChatList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                storyAvatar(
                  'My status',
                  'assets/images/profile-image.png',
                  showOverlay: true,
                ),
                storyAvatar(
                  'Adil',
                  'assets/images/adil.png',
                  bgColor: Color(bgcolor1),
                  showOverlay: false,
                ),
                storyAvatar(
                  'Marina',
                  'assets/images/alex.png',
                  bgColor: Color(bgcolor2),
                ),
                storyAvatar(
                  'Dean',
                  'assets/images/dean.png',
                  bgColor: Color(bgcolor3),
                ),
                storyAvatar(
                  'Max',
                  'assets/images/max.png',
                  bgColor: Color(bgcolor4),
                  showOverlay: false,
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  var chat = chats[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ), // 👈 gap between tiles
                    child: Slidable(
                      key: ValueKey(chat['name']), // Unique key
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          // Wrap both buttons in a row to fully control spacing
                          CustomSlidableAction(
                            flex: 1,
                            onPressed: (context) {},
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min, // 👈 Prevents extra spacing
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ), // 👈 Small spacing between buttons
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageScreen(
                                name: chat['name'],
                                avatar: chat['avatar'],
                              ),
                            ),
                          );
                        },
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(chat['avatar']),
                              radius: 25,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 6,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          chat['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          chat['message'],
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(chat['time'], style: TextStyle(fontSize: 12)),
                            if (chat['unread'] > 0)
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${chat['unread']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupsList() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calls', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/adil.png'),
              radius: 25,
            ),
            title: Text('Adil', style: TextStyle(color: Colors.white)),
            subtitle: Text('2 min ago', style: TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_received, color: Colors.green),
                SizedBox(width: 10),
                Icon(Icons.call, color: Colors.green),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: 'Adil',
                    avatar: 'assets/images/adil.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/alex.png'),
              radius: 25,
            ),
            title: Text('Marina', style: TextStyle(color: Colors.white)),
            subtitle: Text('5 min ago', style: TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_made, color: Colors.blue),
                SizedBox(width: 10),
                Icon(Icons.call, color: Colors.green),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: 'Marina',
                    avatar: 'assets/images/alex.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/dean.png'),
              radius: 25,
            ),
            title: Text('Dean', style: TextStyle(color: Colors.white)),
            subtitle: Text('10 min ago', style: TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_missed, color: Colors.red),
                SizedBox(width: 10),
                Icon(Icons.call, color: Colors.green),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: 'Dean',
                    avatar: 'assets/images/dean.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/max.png'),
              radius: 25,
            ),
            title: Text('Max', style: TextStyle(color: Colors.white)),
            subtitle: Text('1 hour ago', style: TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call_received, color: Colors.green),
                SizedBox(width: 10),
                Icon(Icons.videocam, color: Colors.green),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CallScreen(name: 'Max', avatar: 'assets/images/max.png'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Contacts', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/adil.png'),
              radius: 25,
            ),
            title: Text('Adil', style: TextStyle(color: Colors.white)),
            subtitle: Text('Online', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.message, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    name: 'Adil',
                    avatar: 'assets/images/adil.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/alex.png'),
              radius: 25,
            ),
            title: Text('Marina', style: TextStyle(color: Colors.white)),
            subtitle: Text(
              'Last seen 5 min ago',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.message, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    name: 'Marina',
                    avatar: 'assets/images/alex.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/dean.png'),
              radius: 25,
            ),
            title: Text('Dean', style: TextStyle(color: Colors.white)),
            subtitle: Text('Online', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.message, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    name: 'Dean',
                    avatar: 'assets/images/dean.png',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/max.png'),
              radius: 25,
            ),
            title: Text('Max', style: TextStyle(color: Colors.white)),
            subtitle: Text(
              'Last seen 1 hour ago',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.message, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    name: 'Max',
                    avatar: 'assets/images/max.png',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  int bgcolor1 = 0xFFFFC746;
  int bgcolor2 = 0xFFEDA0A8;
  int bgcolor3 = 0xFF98A1F1;
  int bgcolor4 = 0xFFFBDC94;
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Alex Linderson',
      'message': 'How are you today?',
      'time': '2 min ago',
      'unread': 3,
      'avatar': 'assets/images/profile-image.png',
    },
    {
      'name': 'Team Align',
      'message': "Don't miss to attend the meeting.",
      'time': '2 min ago',
      'unread': 4,
      'avatar': 'assets/images/adil.png',
    },
    {
      'name': 'John Ahraham',
      'message': 'Hey! Can you join the meeting?',
      'time': '2 min ago',
      'unread': 0,
      'avatar': 'assets/images/alex.png',
    },
    {
      'name': 'Sabila Sayma',
      'message': 'How are you today?',
      'time': '2 min ago',
      'unread': 0,
      'avatar': 'assets/images/dean.png',
    },
    {
      'name': 'John Borino',
      'message': 'Have a good day 🌸',
      'time': '2 min ago',
      'unread': 0,
      'avatar': 'assets/images/max.png',
    },
  ];

  Widget _buildProfileScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text('Profile Screen', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget storyAvatar(
    String name,
    String imagePath, {
    Color bgColor = Colors.grey, // default background color
    bool showOverlay = false, // optional overlay
    String overlayIcon = 'assets/images/images/person-icon.png',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: bgColor,
                radius: 30,
                child: CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 27,
                  backgroundColor: Colors.transparent,
                ),
              ),
              if (showOverlay)
                Positioned(
                  top: 40,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, size: 15, color: Colors.black),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
