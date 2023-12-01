import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          // User Profile picture
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),

          // username
          title: Text('Demo User'),

          // last message
          subtitle: Text('Last Message Time'),

          // last message time
          trailing: Text('12:00 PM',style: TextStyle(color: Colors.black54),),
        ),
      ),
    );
  }
}
