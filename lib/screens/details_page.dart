import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';

class FruitDetailsScreen extends StatelessWidget {
  const FruitDetailsScreen(
      {super.key,
      required this.fruit,
      required this.onAddTap,
      required this.onRemoveTap});

  final Fruit fruit;
  final Function onAddTap;
  final Function onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(fruit.name),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage("assets/${fruit.image}"),
                width: 150,
                height: 150,
              ),
              Text(
                fruit.name,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "${fruit.price.toStringAsFixed(2)} €",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              ElevatedButton(
                onPressed: () => onRemoveTap(fruit),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: const Text("Supprimer du panier",
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => onAddTap(fruit),
          tooltip: "Ajouter au panier",
          child: const Icon(Icons.add),
        ));
  }
}
