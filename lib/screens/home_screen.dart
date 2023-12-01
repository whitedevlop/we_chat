// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/widget/chat_user_card.dart';

import '../api/apis.dart';
import '../main.dart';
import'dart:converter';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        leading: Icon(CupertinoIcons.decrease_indent),
        actions: [
          //search user button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),

          //more feature button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
        title: Text('We Chat'),
      ),

      //floating button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),

      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          final list = [];
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            for (var i in data!) {
              print('data: ${jsonEncode(i.data())}');
              list.add(i.data()['name']);
            }
          }
          return ListView.builder(
            itemCount: list.length,
            padding: EdgeInsets.only(top: mq.height * 0.01),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // return ChatUserCard();
              return Text('Name: ${list[index]}');
            },
          );
        },
      ),
    );
  }
}
