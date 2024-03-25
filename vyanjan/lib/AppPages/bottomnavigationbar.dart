import 'package:flutter/material.dart';
import 'package:vyanjan/AppPages/add.dart';
import 'package:vyanjan/AppPages/home.dart';
import 'package:vyanjan/AppPages/profile.dart';
import 'package:vyanjan/AppPages/search.dart';

class bottomnavigationbar extends StatefulWidget {

  @override
  State<bottomnavigationbar> createState() => _bottomnavigationbarState();
}

class _bottomnavigationbarState extends State<bottomnavigationbar> {

  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    List <Widget> pages = [
      home(),
      search(),
      add(),
      profile(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Navigations"),
      ),
      body: pages[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex=index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.deepPurple,
          ),
        ]
      ),
    );
  }
}