import 'package:flutter/material.dart';
import 'package:fruity/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruity',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FruitsMaster(),
    );
  }
}
