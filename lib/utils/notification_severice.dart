import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifiction/utils/message_screen.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// user give permission in your phone allow and Don't allow
  void requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      announcement: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  /// get device token
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  /// refresh token
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("New Token ===> : $event");
    });
  }

  ///

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  ///
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(message.notification?.title);
        print(message.notification?.body);
        print(message.data);
        print(message.data["type"]);
        print(message.data["id"]);
      }
      if (Platform.isIOS) {
        foregroundMessage();
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    /// Android notification
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    /// IOS Notification
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  /// when app is in foreground
  Future<void> setupInteractMessage(BuildContext context) async {
    /// when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    /// when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  /// Navigate to message screen
  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data["type"] == "message") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageScreen(id: message.data["id"]),
        ),
      );
    }
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
