import 'package:e_commerce_app/components/horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../components/products.dart';
import 'cart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Santos Enoque'),
            accountEmail: const Text('santosenoque.ss@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('My Account'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.shopping_cart),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.dashboard),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text('About'),
              leading: Icon(Icons.help),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FlutterCarousel(
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 300.0,
              showIndicator: true,
              slideIndicator: const CircularSlideIndicator(),
            ),
            items: ['m2', 'm2', 'm2', 'm2', 'm2'].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/$i.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: Text('Categories'),
          ),
          const HorizontalList(),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 15),
            child: Text('Recent Products'),
          ),
          const Products()
        ]),
      ),
    );
  }
}
