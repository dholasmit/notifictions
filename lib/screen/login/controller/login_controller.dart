import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notifiction/screen/base_screen/base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password, context) async {
    await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      debugPrint("User Login up: ${value.user?.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );

      /// Save login state in SharedPreferences
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setBool("IsLogin", true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Suscessfully logged in"),
          backgroundColor: Colors.green,
        ),
      );

      ///
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error: Invalid credentials"),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint("Error Login up: $error");
    });
  }
}
