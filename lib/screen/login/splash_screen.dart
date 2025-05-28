import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notifiction/screen/base_screen/base_screen.dart';
import 'package:notifiction/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () async {
        /// firebase auth check
        // final _auth = FirebaseAuth.instance;
        // if (_auth.currentUser == null) {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const LoginScreen(),
        //     ),
        //   );
        // } else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const HomeScreen(),
        //     ),
        //   );
        // }
        /// shard preferences check
        SharedPreferences _pref = await SharedPreferences.getInstance();
        if (_pref.getBool("IsLogin") == null ||
            _pref.getBool("IsLogin") == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BaseScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        "assets/splash.png",
        height: 200,
      ),
    ));
  }
}
