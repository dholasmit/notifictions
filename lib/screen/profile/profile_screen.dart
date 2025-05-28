import 'package:flutter/material.dart';
import 'package:notifiction/screen/login/login_screen.dart';
import 'package:notifiction/utils/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? displayName;
  String? email;
  String? photoURL;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    print("");
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
      email = prefs.getString('email');
      photoURL = prefs.getString('photoURL');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: photoURL != null && photoURL!.isNotEmpty
                      ? NetworkImage(photoURL!)
                      : null,
                  child: photoURL == null || photoURL!.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
                const SizedBox(height: 25),
                Text(
                  displayName ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  email ?? 'No Email',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 100),
                MaterialButton(
                  onPressed: () async {
                    await AuthService().signOutGoogle();
                    SharedPreferences _pref =
                        await SharedPreferences.getInstance();
                    await _pref.setBool("IsLogin", false);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  color: Colors.black,
                  minWidth: double.infinity,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
