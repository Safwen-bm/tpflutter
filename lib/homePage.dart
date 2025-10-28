import 'package:flutter/material.dart';
import 'package:tp2/itemHome.dart';

class Homepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ItemHome(),
        ItemHome(),
        ItemHome(),
        ItemHome(),
      ],
    );
  }
}