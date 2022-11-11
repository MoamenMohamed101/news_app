import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsLayout extends StatelessWidget {
  NewsLayout({Key? key}) : super(key: key);
  List screens = [];
  List appBar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(),
      //bottomNavigationBar: BottomNavigationBar(items: const []),
    );
  }
}
