import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 8,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {},
        ),
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Text(
                  'Inbox',
                  style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: _selectedIndex == 1 ? Colors.blue : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _selectedIndex == 0
                ? buildInboxListView() // Show Inbox ListView
                : buildRequestListView(), // Show Request ListView
          ),
        ],
      ),
    );
  }

  Widget buildInboxListView() {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        final Message chat = chats[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(
                user: chat.sender,
              ),
            ),
          ),
          onLongPress: () {
            _inboxbottomSheet(context, chat.sender);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(chat.sender.imageUrl),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            chat.sender.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            chat.time,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          chat.text,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildRequestListView() {
  return ListView.builder(
    itemCount: requests.length,
    itemBuilder: (BuildContext context, int index) {
      final Message request = requests[index];
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              user: request.sender,
            ),
          ),
        ),
        onLongPress: () {
          _requestBottomSheet(context, request.sender);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(2),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,

                // ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(request.sender.imageUrl),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          request.sender.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          request.time,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        request.text,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _requestBottomSheet(BuildContext context, User sender) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    )),
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text("Accept & Move to Primary"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Delete Chat"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Block"),
          ),
        ],
      );
    },
  );
}

void _inboxbottomSheet(BuildContext context, User sender) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    )),
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text("Mute"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Delete Chat"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Block"),
          ),
        ],
      );
    },
  );
}
