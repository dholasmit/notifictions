import 'package:flutter/material.dart';
import 'package:notifiction/screen/login/common/common.dart';
import 'package:notifiction/screen/login/controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeySinUp = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKeySinUp,
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "Register buddy!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  commonTxtField(
                    labelText: "Name",
                    icon: Icons.person_outline,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  commonTxtField(
                    labelText: "Email",
                    icon: Icons.email_outlined,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  commonTxtField(
                    labelText: "Password",
                    icon: Icons.lock_outline,
                    controller: passWordController,
                    isObscure: isVisible,
                    suffixIcon:
                        isVisible ? Icons.visibility_off : Icons.visibility,
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  btn(
                    context: context,
                    text: "Sign Up",
                    onPressed: () async {
                      disposeKeyboard(context);
                      if (_formKeySinUp.currentState!.validate()) {
                        SignUpController signUpController = SignUpController();
                        await signUpController.signUpUser(
                          emailController.text,
                          passWordController.text,
                          context,
                          nameController.text,
                        );
                      }
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
