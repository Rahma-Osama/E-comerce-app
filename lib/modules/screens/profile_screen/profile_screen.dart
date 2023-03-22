import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/models/user_model.dart';
import 'package:untitled8/modules/screens/cart_screen/cart_layout.dart';
import 'package:untitled8/modules/screens/cart_screen/cart_screen.dart';
import 'package:untitled8/modules/screens/categories_screen/categories_Screen.dart';
import 'package:untitled8/modules/screens/favorites_screen/faorites_layout.dart';
import 'package:untitled8/modules/screens/update_data.dart';
import '../../../shared/components/components.dart';
import '../../../shared/consetennts/const.dart';
import '../../../shared/network/local_network.dart';
import '../../login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if( BlocProvider.of<LayoutCubit>(context).userModel == null ) BlocProvider.of<LayoutCubit>(context).getUsersData();
    print(token!);
    return  BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context , state){},
      builder: (context , state)=>SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
          child: Center(
            child: Column(
              children: [
               BlocProvider.of<LayoutCubit>(context).userModel != null ?
               Column(
                 children:
                 [
                   CircleAvatar(
                     backgroundColor: Colors.grey[200],
                     radius: 70,
                     child: Icon(Icons.person,color: Colors.green,size: 70,),
                   ),
                   SizedBox(height: 20,),
                   // Text("Rahma Osama",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 25),),
                   Text("${BlocProvider.of<LayoutCubit>(context).userModel!.name!}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 25),),
                   SizedBox(height: 10,),
                   Text("${BlocProvider.of<LayoutCubit>(context).userModel!.email!}",style: TextStyle(color: Colors.grey,fontSize: 18),),
                   // Text("rahma@email",style: TextStyle(color: Colors.grey,fontSize: 18),),
                   SizedBox(height: 20,),
                 ],
               ) :
                   Center(
                     child: CircularProgressIndicator(),
                   ),
                InkWell(
                    onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateData())),
                    child: profileOptiosLayout(icon: Icons.person,title: "Update Data")),
                SizedBox(height: 20,),
                InkWell(onTap : (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CartLayout()));},child: profileOptiosLayout(icon: Icons.shopping_cart,title: "Orders")),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesLayout()));
                    },
                    child: profileOptiosLayout(icon: Icons.favorite,title: "Favorite")),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Are you sure?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        elevation: 0,
                                        color: Colors.grey,
                                        onPressed:()=>Navigator.pop(context) ,
                                      child: Text("Cancel"),),

                                      SizedBox(width: 20,),
                                      MaterialButton(
                                        elevation: 0,
                                        color: Colors.green,
                                        onPressed:()async{
                                          Navigator.pop(context);

                                          BlocProvider.of<LayoutCubit>(context).logOut(context);
                                        },
                                        child: const Text("Log out"),)
                                    ],
                                  )
                                ],
                              ),
                      ));

                    },
                    child: profileOptiosLayout(icon: Icons.logout,title: "Log out")),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
