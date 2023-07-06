import 'package:custom_slide_drawer/custom_slide_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int indexPage = 0;
  late bool stateDrawer = false;
  final List<String> titles = ['Home', 'Favorites', 'My Cart', 'Notifications'];
  final List<Widget> children = [
    Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    ),
    Container(
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: const Text(
        'Favorites',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    ),
    Container(
      color: Colors.redAccent,
      alignment: Alignment.center,
      child: const Text(
        'My Cart',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    ),
    Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'Notifications',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSlideDrawer(
        indexPage: indexPage,
        changePage: (int index) {
          setState(() {
            indexPage = index;
          });
        },
        stateDrawer: stateDrawer,
        openDrawer: (value) {
          setState(() {
            stateDrawer = value;
          });
        },
        titles: titles,
        children: children,
      ),
    );
  }
}
