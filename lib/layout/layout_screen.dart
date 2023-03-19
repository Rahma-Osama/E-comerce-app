import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/modules/screens/search_screen/searh_screen.dart';

import '../shared/consetennts/const.dart';
import 'layout_cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context ,state) {},
        builder:(context , state ) {
        var cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text("Fashion Store",),
        actions: [
          IconButton(onPressed: (){
            BlocProvider.of<LayoutCubit>(context).searchedProducts=[];
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
          }, icon: Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        onTap:(value){
          cubit.changeIndex(value);
        },
        currentIndex: cubit.bottomNavBarIndex ,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "WhishedList"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],

      ),
          body:cubit.screens[cubit.bottomNavBarIndex],
    ); } );
  }
}
