import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/widgets/fruit_preview.dart';
import 'package:fruity/screens/details_page.dart';

List<String> fruitsNames = [
  "Ananas",
  "Banane",
  "Cassis",
  "Citron",
  "Citron-vert",
  "Fraise",
  "Framboise",
  "Fruit-de-la-passion",
  "Goyave",
  "Grenade",
  "Kaki",
  "Kiwi",
  "Litchi",
  "Mangue",
  "Melon",
  "Mure",
  "Myrtille",
  "Orange",
  "Pasteque",
  "Peche",
  "Poire",
  "Pomelo",
  "Pomme",
];

List<Color> fruitsColors = [
  Colors.yellow,
  Colors.purple,
  Colors.green,
  Colors.red,
  Colors.deepPurple,
  Colors.lightGreen,
  Colors.redAccent,
  Colors.orange,
  Colors.brown,
  Colors.greenAccent,
  Colors.orangeAccent,
  Colors.pink,
  Colors.blueAccent,
];

List<double> fruitsPrices = [
  0.5,
  0.6,
  0.7,
  0.8,
  0.9,
  1.0,
  1.1,
  1.2,
  1.3,
  1.4,
  1.5,
  1.6,
  1.7,
  1.8,
  1.9,
  2.0,
  2.1,
  2.2,
  2.3,
  2.4,
];

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({super.key, required this.fruits});

  final List<Fruit> fruits;

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  late List<Fruit> _fruits;
  late List<Fruit> _cart;
  late double _sum;

  @override
  void initState() {
    super.initState();
    _fruits = widget.fruits;
    _cart = [];
    _sum = 0;
  }

  void _onFruitTap(fruit) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FruitDetailsScreen(
                fruit: fruit, onAddTap: _addFruit, onRemoveTap: _removeFruit)));
  }

  void _addFruit(fruit) {
    setState(() {
      _cart.add(fruit);
      _sum += fruit.price;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text(
        "Ajouté au panier !",
        style: TextStyle(fontSize: 16),
      )),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 25),
      duration: Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      elevation: 5,
    ));
  }

  void _removeFruit(fruit) {
    if (_cart.contains(fruit) && _cart.isNotEmpty) {
      setState(() {
        _cart.remove(fruit);
        _sum -= fruit.price;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          "Retiré du panier !",
          style: TextStyle(fontSize: 16),
        )),
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 25),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.startToEnd,
        elevation: 5,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          "Ce produit n'est pas dans le panier !",
          style: TextStyle(fontSize: 16),
        )),
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(vertical: 25),
        duration: Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.startToEnd,
        elevation: 5,
      ));
    }
  }

  void _createFruit() {
    setState(() {
      _fruits.insert(
          0,
          Fruit(
              name: fruitsNames[Random().nextInt(fruitsNames.length)],
              color: fruitsColors[Random().nextInt(fruitsColors.length)],
              price: fruitsPrices[Random().nextInt(fruitsPrices.length)]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Panier : ${_sum.toStringAsFixed(2)} €")),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _fruits.length,
            itemBuilder: (context, index) {
              return FruitPreview(
                  fruit: _fruits[index],
                  onTileTap: _onFruitTap,
                  onAddTap: _addFruit);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createFruit(),
        tooltip: 'Ajouter un fruit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
