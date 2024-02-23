import 'package:e_commerce_app/components/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: CartProducts(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(children: [
          const Expanded(
            child: ListTile(
              title: Text("Total:"),
              subtitle: Text('\$230'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Expanded(
                child: MaterialButton(
              onPressed: () {},
              color: Colors.red,
              child: const Text(
                "Check out",
                style: TextStyle(color: Colors.white),
              ),
            )),
          )
        ]),
      ),
    );
  }
}
