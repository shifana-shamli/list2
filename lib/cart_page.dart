import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void saveProductToHive(String product) async {
  var box = await Hive.openBox('yourBook');
  await box.add(product);
}

Future<List> getProductsFromHive() async {
  var box = await Hive.openBox('your book');
  return box.values.toList().cast<String>();
}



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('cart');
    List items = box.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Cart page'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index].itemName),
            trailing: Text('Quantity: ${items[index].quantity}'),
          );
        },
      ),
    );
  }
}
