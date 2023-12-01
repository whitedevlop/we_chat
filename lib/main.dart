import 'package:flutter/material.dart';
// import 'package:we_chat/screens/auth/login_screen.dart';
// import 'package:we_chat/screens/home_screen.dart';
//firebase dependencies
import 'package:firebase_core/firebase_core.dart';
import 'package:we_chat/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

//global objects for accessing the mediaquery
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to potrait onlu solving FUTURE return
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 1,
            color: Color.fromARGB(223, 252, 235, 234),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 19,
              // backgroundColor: Colors.white
            )),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 244, 67, 54)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
