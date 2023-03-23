import 'package:flutter/material.dart';

class Fruit {
  String name;
  double price;
  String image;
  Color color;
  int stock;
  int origin;
  String season;

  Fruit(
      {required this.name,
      required this.color,
      required this.price,
      required this.image,
      required this.stock,
      required this.origin,
      required this.season});

  Fruit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        image = json['image'],
        color = Color(
            int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
        stock = json['stock'],
        origin = json['origin'],
        season = json['season'];
}
