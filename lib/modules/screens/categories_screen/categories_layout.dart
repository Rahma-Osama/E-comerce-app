import 'package:flutter/material.dart';
import 'package:untitled8/modules/screens/categories_screen/categories_Screen.dart';
import 'package:untitled8/modules/screens/favorites_screen/WhishedList_screen.dart';
class CategoriesLayout extends StatelessWidget {
  const CategoriesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text("Categories",),
      ),
      body: CategoriesScreen(),
    );
  }
}
