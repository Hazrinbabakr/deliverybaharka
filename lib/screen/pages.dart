// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:deliverybaharka/screen/Favorites.dart';
import 'package:deliverybaharka/screen/cart_screen.dart';
import 'package:deliverybaharka/screen/order_history.dart';
import 'package:deliverybaharka/screen/profile.dart';
import 'package:flutter/material.dart';
import 'home.dart';
class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int currentTabIndex=0;

  onTapped(int index) {
    setState(() {
      currentTabIndex=index;
    });
    if(currentTabIndex==3){
    }
  }

  final currentPage = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: currentPage[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        selectedItemColor: Colors.red[900],
        currentIndex: currentTabIndex,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.favorite_border),
            title: Text(''),
            // backgroundColor: Colors.purple[600]
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.shopping_cart_outlined),
            title: Text(''),
            // backgroundColor: Colors.purple[600]
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(""),
          ),

        ],
      ),
    );
  }
}
