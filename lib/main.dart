import 'package:flutter/material.dart';
import 'package:fruity/providers/cart_provider.dart';
import 'package:fruity/screens/fruit_master_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child: const MyApp()));
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
