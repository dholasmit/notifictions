import 'package:flutter/material.dart';
import 'package:notifiction/screen/login/common/common.dart';
import 'package:notifiction/utils/auth_service.dart';

class ForgotPassWordScreen extends StatefulWidget {
  const ForgotPassWordScreen({super.key});

  @override
  State<ForgotPassWordScreen> createState() => _ForgotPassWordScreenState();
}

class _ForgotPassWordScreenState extends State<ForgotPassWordScreen> {
  final _auth = AuthService();
  final _formKeyForgot = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKeyForgot,
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 30),
                  btn(
                    context: context,
                    text: "Send Email",
                    onPressed: () {
                      disposeKeyboard(context);
                      if (_formKeyForgot.currentState!.validate()) {
                        _auth.sendPasswordResetEmail(
                            emailController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password reset email sent!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
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
