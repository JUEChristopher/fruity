import 'package:flutter/material.dart';
import '../classes/fruit.dart';

class CartProvider extends ChangeNotifier {
  final List<Fruit> _cart = [];
  double _sum = 0;

  List<Fruit> get cart => _cart;
  double get sum => _sum;

  void addToCart(Fruit fruit) {
    _cart.add(fruit);
    _sum += fruit.price;
    notifyListeners();
  }

  void removeFromCart(Fruit fruit) {
    _cart.remove(fruit);
    _sum -= fruit.price;
    notifyListeners();
  }

  int numberTypeFruitSelected(Fruit fruit) {
    int i = 0;
    for (var fruit in _cart) {
      if (fruit.name == fruit.name) {
        i++;
      }
    }

    return i;
  }
}
