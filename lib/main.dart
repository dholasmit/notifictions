import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notifiction/utils/notification_severice.dart';

import 'screen/login/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // NotificationService notificationService = NotificationService();
  // notificationService.getDeviceToken().then((value) {
  //   print("DEVICE TOKEN ===> : $value");
  // });

  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print("onMessage: ${message.notification!.title}");
  print("Data : ${message.data}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications Demo',
      home: SplashScreen(),
    );
  }
}
