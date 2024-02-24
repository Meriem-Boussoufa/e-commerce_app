import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({super.key});

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnTheCart = [
    {
      "name": "Shoe",
      "picture": "assets/images/shoe1.jpeg",
      "old_price": 120,
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Blazer",
      "picture": "assets/images/m2.jpg",
      "old_price": 120,
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsOnTheCart.length,
      itemBuilder: (context, index) {
        return SingleCartProducts(
          productName: productsOnTheCart[index]["name"],
          productPicture: productsOnTheCart[index]["picture"],
          productColor: productsOnTheCart[index]["color"],
          productQuantity: productsOnTheCart[index]["quantity"],
          productOldPrice: productsOnTheCart[index]["old_price"],
          productPrice: productsOnTheCart[index]["price"],
          productSize: productsOnTheCart[index]["size"],
        );
      },
    );
  }
}

class SingleCartProducts extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final productName;
  // ignore: prefer_typing_uninitialized_variables
  final productPicture;
  // ignore: prefer_typing_uninitialized_variables
  final productOldPrice;
  // ignore: prefer_typing_uninitialized_variables
  final productPrice;
  // ignore: prefer_typing_uninitialized_variables
  final productSize;
  // ignore: prefer_typing_uninitialized_variables
  final productColor;
  // ignore: prefer_typing_uninitialized_variables
  final productQuantity;

  const SingleCartProducts(
      {super.key,
      this.productName,
      this.productPicture,
      this.productOldPrice,
      this.productPrice,
      this.productSize,
      this.productColor,
      this.productQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40, // Adjust width as needed
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_up,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Text("$productQuantity"),
            const SizedBox(width: 5),
            SizedBox(
              width: 40, // Adjust width as needed
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ],
        ),
        leading: Image.asset(
          productPicture,
          width: 80,
          height: 80,
        ),
        title: Text(productName),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Text("Size :"),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      productSize,
                      style: const TextStyle(color: Colors.red),
                    )),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Color:"),
                ),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      productColor,
                      style: const TextStyle(color: Colors.red),
                    )),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$$productPrice",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
