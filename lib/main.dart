import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [
    Fruit(name: "Pomme", color: Colors.green.shade700, price: 2.20),
    Fruit(name: "Orange", color: Colors.orange.shade700, price: 1.60),
    Fruit(name: "Mangue", color: Colors.orange.shade300, price: 2.70),
    Fruit(name: "Poire", color: Colors.lightGreen.shade400, price: 1.50),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruity',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FruitsMaster(fruits: fruits),
    );
  }
}
