import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/layout_cubit/layout_cubit.dart';
import '../../../layout/layout_cubit/layout_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context , listner){

        },

        builder: (context,listner)=> cubit.cart.isEmpty ?Center(child: CircularProgressIndicator(color: Colors.green,))
        : Column(
      children: [
        Expanded(
          child: ListView.separated(
              itemBuilder: (context,index)=>Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(child: Image.network(cubit.cart[index].image!,)),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cubit.cart[index].name!,style: TextStyle(fontWeight: FontWeight.bold),maxLines:3,overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 10,),
                          Text(cubit.cart[index].price!.toString()+ " \$",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                          SizedBox(height: 10,),
                          MaterialButton(onPressed: (){
                            cubit.addOrRemoveFromcart(id: cubit.cart[index].id!.toString());
                          },color: Colors.red,child:Text("Remove from cart",style: TextStyle(color: Colors.white),),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              separatorBuilder: (context,state)=>Divider(thickness: 2,color: Colors.green,),
              itemCount: cubit.cart.length),
        ),
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          ),
          child: Center(child:  Text("Total : ${cubit.total} \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.white ))),
        )
      ],
    )

    );
  }
}
