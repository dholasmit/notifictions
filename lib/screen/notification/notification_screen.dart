import 'package:flutter/material.dart';
import 'package:notifiction/utils/auth_service.dart';
import 'package:notifiction/utils/notification_severice.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationService notificationService = NotificationService();

  @override
  final _auth = AuthService();

  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermissions();
    // notificationService.isTokenRefresh();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    notificationService.foregroundMessage();
    // notificationService.getDeviceToken().then((value) {
    //   print("DEVICE TOKEN ===> : $value");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurantImage.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              tileColor: Colors.grey.shade400,
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(256),
                  image: DecorationImage(
                    image: AssetImage(restaurantImage[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(restaurantName[index]),
              subtitle: Text(restaurantAddress[index]),
              trailing: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}

List<String> restaurantImage = [
  "assets/restro_image.jpg",
  "assets/restro_image_2.jpg",
  "assets/restro_image_3.jpg",
  "assets/restro_image_4.jpg",
  "assets/restro_image_5.jpg",
  "assets/restro_image_6.jpg",
  "assets/restro_image_7.jpg",
  "assets/restro_image_2.jpg",
  "assets/restro_image_3.jpg",
  "assets/restro_image_4.jpg",
];
List<String> restaurantName = [
  "Agashiye – The House of MG",
  "Rajwadu Garden Restaurant",
  "Vishalla Restaurant",
  "Tinello – Hyatt Regency",
  "The Green House",
  "Pleasure Trove",
  "Skyz Restaurant & Banquet",
  "Little Italy",
  "Gordhan Thal",
  "Birmies",
];
List<String> restaurantAddress = [
  " The House of MG, Sidi Saiyed Mosque, Lal Darwaja, Ahmedabad",
  "Near Jivraj Tolnaka, Malav Talav, Vejalpur, Ahmedabad",
  " Opposite APMC Market, Vasna, Ahmedabad",
  "17/A, Ashram Road, Usmanpura, Ahmedabad",
  "The House of MG, Lal Darwaja, Ahmedabad",
  "Opposite Town Hall, Ellis Bridge, Ahmedabad",
  "Near Karnavati Club, S.G. Highway, Ahmedabad",
  "Bodakdev, Ahmedabad",
  "S.G. Highway, Ahmedabad",
  "Ground Floor, Shapath Complex, S.G. Highway, Satellite, Ahmedabad",
];

/// this code is working without CircularProgressIndicator
// TextButton(
//   onPressed: () async {
//     await _auth.signInWithGoogle();
//     final user = await _auth.getUser();
//     if (user != null) {
//       print("NAME : ${user.displayName}");
//       print("EMAIL : ${user.email}");
//       print("PHOTO : ${user.photoURL}");
//       print("MOBILE NUMBER : ${user.phoneNumber}");
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProfileScreen(user: user),
//         ),
//       );
//     }
//   },
//   child: Text("Google Login"),
// ),
