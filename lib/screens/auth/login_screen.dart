// import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/api/apis.dart';
import 'package:we_chat/helper/dialogs.dart';
import 'package:we_chat/screens/home_screen.dart';
import '../../main.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    //for showing progress indicator
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      //for hiding progressbar
      Navigator.pop(context);
      if (user != null) {
        print("\nUser: ${user.user}");
        print("\nUserAdditionalInfo: ${user.additionalUserInfo}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      print("\n _signInWithGoogle: $e");
      Dialogs.showSnackbar(context, 'Something went wrong(Check Internet)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      //appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to We Chat'),
      ),

      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * 0.15,
            right: _isAnimate ? mq.width * 0.30 : -mq.width * 0.4,
            width: mq.width * 0.4,
            duration: Duration(seconds: 1),
            child: Image.asset(
              'images/We_Chat.png',
            ),
          ),
          Positioned(
            bottom: mq.height * 0.15,
            left: mq.width * 0.20,
            width: mq.width * 0.65,
            child: ElevatedButton.icon(
              onPressed: () {
                _handleGoogleBtnClick();
              },
              icon: Image.asset(
                'images/google.png',
                scale: 20,
              ),
              label: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: 'Sign in with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 122, 122, 122))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
