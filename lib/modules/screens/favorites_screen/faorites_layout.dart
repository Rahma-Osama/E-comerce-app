import 'package:flutter/material.dart';
import 'package:untitled8/modules/screens/favorites_screen/WhishedList_screen.dart';
class FavoritesLayout extends StatelessWidget {
  const FavoritesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text("Favorites",),
      ),
          body: WhishedScreen(),
    );
  }
}
