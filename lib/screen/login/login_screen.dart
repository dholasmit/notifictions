import 'package:flutter/material.dart';
import 'package:notifiction/screen/base_screen/base_screen.dart';
import 'package:notifiction/screen/login/common/common.dart';
import 'package:notifiction/screen/login/controller/login_controller.dart';
import 'package:notifiction/screen/login/forgot_password.dart';
import 'package:notifiction/screen/login/signu_screen.dart';
import 'package:notifiction/utils/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  bool isVisible = false;
  bool isLoading = false;
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        disposeKeyboard(context);
      },
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKeyLogin,
                    child: SingleChildScrollView(
                      child: // Show loading indicator if isLoading is true
                          Column(
                        children: [
                          const SizedBox(height: 130),
                          const Text("Sign In",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
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
                          const SizedBox(
                            height: 20,
                          ),
                          commonTxtField(
                            labelText: "Password",
                            icon: Icons.lock_outline,
                            controller: passWordController,
                            isObscure: isVisible,
                            suffixIcon: isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTapUp: (details) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassWordScreen(),
                                      ));
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          btn(
                            context: context,
                            text: "Sign In",
                            onPressed: () async {
                              disposeKeyboard(context);
                              if (_formKeyLogin.currentState!.validate()) {
                                LoginCController loginCController =
                                    LoginCController();
                                await loginCController.loginUser(
                                    emailController.text,
                                    passWordController.text,
                                    context);

                                print("Email: ${emailController.text}");
                                print("PassWord: ${passWordController.text}");
                                // Perform login action
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: divider(),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Or Continue with",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: divider(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              // Platform.isAndroid
                              //     ?
                              GestureDetector(
                                onTapUp: (details) {
                                  _googleLogin();
                                },
                                child: Image.asset(
                                  "assets/09-google-3-512.webp",
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              // const SizedBox(width: 20),
                              // // :
                              // Image.asset(
                              //   "assets/mac-os.png",
                              //   height: 50,
                              //   width: 50,
                              // ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              const Text(
                                "Not a member?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTapUp: (details) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ));
                                },
                                child: const Text(
                                  "  Register Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _googleLogin() async {
    setState(() {
      isLoading = true;
    });
    await _auth.signInWithGoogle();
    final user = await _auth.getUser();
    if (user != null) {
      print("NAME : ${user.displayName}");
      print("EMAIL : ${user.email}");
      print("PHOTO : ${user.photoURL}");
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
