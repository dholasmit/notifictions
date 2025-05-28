import 'package:flutter/material.dart';
import 'package:notifiction/screen/home/home_screen.dart';
import 'package:notifiction/screen/notification/notification_screen.dart';
import 'package:notifiction/screen/payment/payment_screen.dart';
import 'package:notifiction/screen/profile/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const NotificationScreen(),
    // const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _currentIndex == 0
            ? const Text("Home Screen")
            : _currentIndex == 1
                ? const Text("Notification Screen")
                : const Text("Profile Screen"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentScreen()));
            },
            icon: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.black,
      ),
    );
  }
}
