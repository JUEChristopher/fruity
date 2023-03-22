import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/widgets/cart_screen.dart';
import 'package:fruity/widgets/fruit_preview.dart';
import 'package:fruity/screens/details_page.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({super.key});

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final dio = Dio();
  late Future<List<Fruit>> _fruits;
  late List<Fruit> _cart;
  late double _sum;

  Future<List<Fruit>> getFruits() async {
    try {
      final response = await dio.get('https://fruits.shrp.dev/items/fruits');
      List<Fruit> listFruitsAPI = [];
      response.data['data']
          .forEach((fruit) => {listFruitsAPI.add(Fruit.fromJson(fruit))});
      return listFruitsAPI;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _fruits = getFruits();
    _cart = [];
    _sum = 0;
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Panier : ${_sum.toStringAsFixed(2)} €")),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FutureBuilder(
                future: _fruits,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return FruitPreview(
                              fruit: snapshot.data![index],
                              onTileTap: _onFruitTap,
                              onAddTap: _addFruit);
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            CartScreen(cart: _cart, onRemoveTap: _removeFruit),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Panier',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ));
  }
}
