import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tp2/chatPage.dart';
import 'package:tp2/homePage.dart';
import 'package:tp2/profilePage.dart';
import 'package:tp2/searchPage.dart';

void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tp2",
      theme:ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:Colors.purple)), 
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  List<Widget> list = [
    Homepage(),
    Searchpage(),
    Chatpage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Navigation")), 
        backgroundColor: Color.fromRGBO(234, 218, 240, 1),
      ),
      body: list[_page],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        backgroundColor: Color.fromRGBO(234, 218, 240, 1),
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: "Home",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search),
            label: "Search",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.message),
            label: "Chat",
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
            label: "Profile",
          ),
        ],
    ));
  }
}