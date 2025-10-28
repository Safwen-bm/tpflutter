import 'package:flutter/material.dart';

class ItemHome extends StatelessWidget {
  const ItemHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        ListTile(
          title: Text("500 dt par mois"),
          subtitle: Text("s+1, 50m"),
          trailing: Icon(Icons.favorite_outline),
        ),
        Container(
          child: Image.asset("assets/home1.jpeg"),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text("Situé à Paris, à moins de 700 mètres de la gare du Nord et à moins de 1 km de la gare de l'Est"),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.end,
            children: [
              TextButton(onPressed: () => {}, child: Text("Vérifier la disponibilité")),
              TextButton(onPressed: () => {}, child: Text("Contactez Nous"))
            ],
          ),
        )
      ],)
    );
  }
}