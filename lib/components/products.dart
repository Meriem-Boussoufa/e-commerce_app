import 'package:e_commerce_app/pages/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Dress",
      "picture": "assets/images/dress2.jpg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "assets/images/dress.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "assets/images/dress3.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "assets/images/dress4.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Shirt",
      "picture": "assets/images/shirt2.jpg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Shirt",
      "picture": "assets/images/shirt0.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Pant",
      "picture": "assets/images/pant1.jpg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Pant",
      "picture": "assets/images/pant3.jpg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Pant",
      "picture": "assets/images/pant2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Shoe",
      "picture": "assets/images/shoe1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Shoe",
      "picture": "assets/images/shoe2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Blazer",
      "picture": "assets/images/m1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Blazer",
      "picture": "assets/images/m2.jpg",
      "old_price": 120,
      "price": 85,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleProduct(
          productName: productList[index]['name'],
          productPicture: productList[index]['picture'],
          productOldPrice: productList[index]['old_price'],
          productPrice: productList[index]['price'],
        );
      },
    );
  }
}

class SingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final productOldPrice;
  final productPrice;
  const SingleProduct(
      {super.key,
      this.productName,
      this.productPicture,
      this.productOldPrice,
      this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: productName,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            productDetailName: productName,
                            productDetailNewPrice: productPrice,
                            productDetailOldPrice: productOldPrice,
                            productDetailPicture: productPicture,
                          )),
                );
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        "\$$productPrice",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
                        productOldPrice.toString(),
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    productPicture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
