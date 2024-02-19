import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Category(
              imageLocation: 'assets/images/shirt.jpeg', imageCaption: 'shirt'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg', imageCaption: 'dress'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg', imageCaption: 'pants'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg',
              imageCaption: 'formal'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg',
              imageCaption: 'informal'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg', imageCaption: 'shoes'),
          Category(
              imageLocation: 'assets/images/shirt.jpeg',
              imageCaption: 'others'),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  const Category(
      {super.key, required this.imageLocation, required this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: 100.0,
          child: ListTile(
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  imageCaption,
                  style: const TextStyle(fontSize: 12.0),
                )),
            title: Image.asset(
              imageLocation,
              width: 80,
              height: 60,
            ),
          ),
        ),
      ),
    );
  }
}
