import 'package:flutter/material.dart';
import 'package:immo_plus/itemHome.dart';
import 'package:immo_plus/offerPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        title: const Text(
          "Accueil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Offer Carousel
          const OfferPage(),

          // Results Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Biens populaires",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Voir tout",
                    style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Property List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                ItemHome(),
                ItemHome(),
                ItemHome(),
                ItemHome(),
                ItemHome(),
                ItemHome(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}