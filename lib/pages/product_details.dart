import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final productDetailName;
  // ignore: prefer_typing_uninitialized_variables
  final productDetailNewPrice;
  // ignore: prefer_typing_uninitialized_variables
  final productDetailOldPrice;
  // ignore: prefer_typing_uninitialized_variables
  final productDetailPicture;

  const ProductDetails(
      {super.key,
      this.productDetailName,
      this.productDetailNewPrice,
      this.productDetailOldPrice,
      this.productDetailPicture});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red.shade900,
        title: const Text(
          "E-Commerce App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.black,
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "\$${widget.productDetailOldPrice}",
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "\$${widget.productDetailNewPrice}",
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                ),
              ),
              child: Container(
                color: Colors.white70,
                child: Image.asset(widget.productDetailPicture),
              ),
            ),
          ),
          //=============== The First Buttons =============== //
          Row(
            children: [
              // ========= The Size Button
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Size'),
                          content: const Text("Choose the size"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: const Row(children: [
                  Expanded(child: Text("Size")),
                  Expanded(child: Icon(Icons.arrow_drop_down)),
                ]),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Color'),
                          content: const Text("Choose the Color"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: const Row(children: [
                  Expanded(child: Text("Color")),
                  Expanded(child: Icon(Icons.arrow_drop_down)),
                ]),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Quantity'),
                          content: const Text("Choose the quantity"),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: const Row(children: [
                  Expanded(child: Text("Qty")),
                  Expanded(child: Icon(Icons.arrow_drop_down)),
                ]),
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red.shade900,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: const Text("Buy Now"),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_shopping_cart),
                color: Colors.red.shade900,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                color: Colors.red.shade900,
              ),
            ],
          ),
          const ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum."),
          ),
          const Divider(),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
              ),
              const Text(
                "Product Name",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(widget.productDetailName.toString()),
              )
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
              ),
              Text(
                "Product Brand",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Brand X"),
              )
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
              ),
              Text(
                "Product Conditions",
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("NEW"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
