import 'package:flutter/material.dart';
import 'package:tp2/itemHome.dart';
import 'package:tp2/offerPage.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OfferPage(),
          Expanded(
            child: ListView(
              children: [
                ItemHome(), 
                ItemHome(), 
                ItemHome(), 
                ItemHome()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
