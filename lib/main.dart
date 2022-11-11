import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/new_layout.dart';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.red,
              statusBarIconBrightness: Brightness.light),
        ),
      ),
      home: NewsLayout(),
    ),
  );
}
