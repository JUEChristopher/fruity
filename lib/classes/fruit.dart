import 'package:flutter/material.dart';

class Fruit {
  String name;
  Color color;
  double price;

  Fruit({required this.name, required this.color, required this.price});

  Fruit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        color = Color(
            int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
        price = json['price'];
}
