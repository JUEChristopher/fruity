import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class FruitDetails extends StatelessWidget {
  const FruitDetails({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

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
                onPressed: () {
                  if (Provider.of<CartProvider>(context, listen: false)
                      .cart
                      .contains(fruit)) {
                    Provider.of<CartProvider>(context, listen: false)
                        .removeFromCart(fruit);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Center(
                          child: Text(
                        "Retiré du panier !",
                        style: TextStyle(fontSize: 16),
                      )),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 25),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.startToEnd,
                      elevation: 5,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Center(
                          child: Text(
                        "Ce fruit n'est pas dans le panier !",
                        style: TextStyle(fontSize: 16),
                      )),
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 25),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      dismissDirection: DismissDirection.startToEnd,
                      elevation: 5,
                    ));
                  }
                },
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
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(fruit);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(
                  child: Text(
                "Ajouté au panier !",
                style: TextStyle(fontSize: 16),
              )),
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 25),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.startToEnd,
              elevation: 5,
            ));
          },
          tooltip: "Ajouter au panier",
          child: const Icon(Icons.add),
        ));
  }
}
