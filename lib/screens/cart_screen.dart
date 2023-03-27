import 'package:flutter/material.dart';
import 'package:fruity/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.cart.isEmpty) {
            return const Center(
              child: Text(
                "Le panier est vide !",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  tileColor: cartProvider.cart[index].color,
                  leading: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/${cartProvider.cart[index].image}",
                      ),
                      width: 38,
                      height: 38,
                    ),
                  ),
                  title: Center(
                    child: Text(cartProvider.cart[index].name),
                  ),
                  subtitle: Center(
                    child: Text(
                      "${cartProvider.cart[index].price.toStringAsFixed(2)} €",
                    ),
                  ),
                  trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cartProvider.removeFromCart(cartProvider.cart[index]);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(
                              child: Text(
                                "Retiré du panier !",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 25),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            dismissDirection: DismissDirection.startToEnd,
                            elevation: 5,
                          ),
                        );
                      }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
