import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/screens/fruit_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:fruity/providers/cart_provider.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

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
          image: AssetImage("assets/${fruit.image}"),
          width: 38,
          height: 38,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(fruit.name),
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
            return Chip(
              label:
                  Text(cartProvider.numberTypeFruitSelected(fruit).toString()),
            );
          }),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add),
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
      ),
      subtitle: Center(
        child: Text("${fruit.price.toStringAsFixed(2)} €"),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FruitDetails(fruit: fruit)));
      },
    );
  }
}
