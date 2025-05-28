import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> restaurants = [
    "assets/restro_image.jpg",
    "assets/restro_image_2.jpg",
    "assets/restro_image_3.jpg",
    "assets/restro_image_4.jpg",
    "assets/restro_image_5.jpg",
    "assets/restro_image_6.jpg",
    "assets/restro_image_7.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Card(
              elevation: 10,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      restaurants[index],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
