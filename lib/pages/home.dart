import 'package:e_commerce_app/components/horizontal_list.dart';
import 'package:e_commerce_app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../components/products.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            decoration: BoxDecoration(
              color: Colors.red.shade900,
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('Home Page'),
              leading: Icon(
                Icons.home,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('My Account'),
              leading: Icon(
                Icons.person,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('My Orders'),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('Categories'),
              leading: Icon(
                Icons.dashboard,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('Favourites'),
              leading: Icon(
                Icons.favorite,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text('About'),
              leading: Icon(
                Icons.help,
                color: Colors.red.shade900,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: logOutUser,
            child: ListTile(
              title: const Text('Sign Out'),
              leading: Icon(
                Icons.logout,
                color: Colors.red.shade900,
                size: 30,
              ),
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

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false);
  }
}
