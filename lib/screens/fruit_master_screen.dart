import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fruity/classes/fruit.dart';
import 'package:fruity/providers/cart_provider.dart';
import 'package:fruity/screens/cart_screen.dart';
import 'package:fruity/widgets/fruit_preview_widget.dart';
import 'package:provider/provider.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({super.key});

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  _FruitsMasterState();

  final dio = Dio();
  late Future<List<Fruit>> _fruits;

  Future<List<Fruit>> getFruits() async {
    try {
      final response = await dio.get('https://fruits.shrp.dev/items/fruits');
      List<Fruit> listFruitsAPI = [];
      response.data['data']
          .forEach((fruit) => {listFruitsAPI.add(Fruit.fromJson(fruit))});
      return listFruitsAPI;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _fruits = getFruits();
  }

  // void _removeFruit(fruit) {
  //   if (_cart.contains(fruit) && _cart.isNotEmpty) {
  //     setState(() {
  //       _cart.remove(fruit);
  //       _sum -= fruit.price;
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Center(
  //           child: Text(
  //         "Retiré du panier !",
  //         style: TextStyle(fontSize: 16),
  //       )),
  //       backgroundColor: Colors.red,
  //       padding: EdgeInsets.symmetric(vertical: 25),
  //       duration: Duration(milliseconds: 1500),
  //       behavior: SnackBarBehavior.floating,
  //       dismissDirection: DismissDirection.startToEnd,
  //       elevation: 5,
  //     ));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Center(
  //           child: Text(
  //         "Ce produit n'est pas dans le panier !",
  //         style: TextStyle(fontSize: 16),
  //       )),
  //       backgroundColor: Colors.orange,
  //       padding: EdgeInsets.symmetric(vertical: 25),
  //       duration: Duration(milliseconds: 1500),
  //       behavior: SnackBarBehavior.floating,
  //       dismissDirection: DismissDirection.startToEnd,
  //       elevation: 5,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          return Center(
              child: Text("Panier : ${cartProvider.sum.toStringAsFixed(2)} €"));
        }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: FutureBuilder(
          future: _fruits,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                      return FruitPreview(
                        fruit: snapshot.data![index],
                      );
                    });
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
