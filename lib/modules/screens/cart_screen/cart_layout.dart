import 'package:flutter/material.dart';
import 'package:untitled8/modules/screens/favorites_screen/WhishedList_screen.dart';

import 'cart_screen.dart';
class CartLayout extends StatelessWidget {
  const CartLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text("Cart",),
      ),

          body: CartScreen(),
    );
  }
}
