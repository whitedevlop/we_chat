// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/screens/auth/login_screen.dart';
import 'package:we_chat/screens/home_screen.dart';
import '../../main.dart';
import 'package:flutter/services.dart';

import '../api/apis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
      if (APIs.auth.currentUser != null) {
        print('\nUser: ${APIs.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      //appbar

      body: Stack(
        children: [
          Positioned(
            top: mq.height * 0.20,
            right: mq.width * 0.30,
            width: mq.width * 0.4,
            child: Image.asset(
              'images/We_Chat.png',
            ),
          ),
          Positioned(
            bottom: mq.height * 0.15,
            width: mq.width,
            child: Text(
              'Made by sanam',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black45, letterSpacing: 1.5, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
