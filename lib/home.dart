import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:immo_plus/chatPage.dart';
import 'package:immo_plus/homePage.dart';
import 'package:immo_plus/profilePage.dart';
import 'package:immo_plus/searchPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  final List<Widget> _pages = [
     Homepage(),
     Searchpage(),
     Chatpage(),
     Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.blue[700],
        color: Colors.blue[50]!,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        height: 65,
        index: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, size: 30),
            label: 'Accueil',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search, size: 30),
            label: 'Recherche',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat_bubble_outline, size: 30),
            label: 'Messages',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person_outline, size: 30),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}