import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart, required this.onRemoveTap});

  final List<Fruit> cart;
  final Function onRemoveTap;

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const Center(
          child: Text("Le panier est vide !", style: TextStyle(fontSize: 20)));
    } else {
      return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                tileColor: cart[index].color,
                leading: Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: AssetImage("assets/${cart[index].image}"),
                    width: 38,
                    height: 38,
                  ),
                ),
                title: Center(
                  child: Text(cart[index].name),
                ),
                subtitle: Center(
                  child: Text("${cart[index].price.toStringAsFixed(2)} €"),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => onRemoveTap(cart[index]),
                ));
          });
    }
  }
}
