// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/Cart/cart_history_screen.dart';
import 'package:food_delivery_app/screens/Home/home_screen.dart';
import 'package:food_delivery_app/utils/colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selesctedIndex = 0;
  List screens = [
    const HomeScreen(),
    Container(
      child: const Text("2nd Page"),
    ),
    const CartHistoryScreen(),
    Container(
      child: const Text("4th Page"),
    ),
  ];
  void onTabScreen(int index) {
    setState(() {
      _selesctedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selesctedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.blueGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selesctedIndex,
          onTap: onTabScreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Me",
            ),
          ]),
    );
  }
}
