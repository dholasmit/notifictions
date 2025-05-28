import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpUser(
      String email, String password, context, String name) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      debugPrint("User signed up: ${value.user?.email}");

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Successfully signed up"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      debugPrint("Error signing up: $error");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Error: Invalid credentials"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
