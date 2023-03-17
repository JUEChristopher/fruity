import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview(
      {super.key,
      required this.fruit,
      required this.onTileTap,
      required this.onAddTap});

  final Fruit fruit;
  final Function onTileTap;
  final Function onAddTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      tileColor: fruit.color,
      leading: Container(
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.brown.shade300,
          shape: BoxShape.circle,
        ),
        child: Image(
          image: AssetImage("assets/${fruit.name.toLowerCase()}.png"),
          width: 38,
          height: 38,
        ),
      ),
      title: Center(
        child: Text(fruit.name),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => onAddTap(fruit),
      ),
      subtitle: Center(
        child: Text("${fruit.price.toStringAsFixed(2)} €"),
      ),
      onTap: () => onTileTap(fruit),
    );
  }
}
