import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
class ProductDetails extends StatelessWidget {
  int? counter;
  ProductDetails({Key? key ,required  this.counter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state)=>Scaffold(
          appBar:  AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            elevation: 0,
            title: Text("Details",),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(color: Colors.white,child: Image.network(BlocProvider.of<LayoutCubit>(context).homeProducts![counter!].image!,height: 200,width: double.infinity,)),
              Text(BlocProvider.of<LayoutCubit>(context).homeProducts![counter!].name!,style: TextStyle(color: Colors.green,fontSize: 20),),
              Expanded(child: SingleChildScrollView(child: Text(BlocProvider.of<LayoutCubit>(context).homeProducts![counter!].description!,style: TextStyle(color: Colors.grey,fontSize: 16),))),
                MaterialButton(onPressed: (){
                  BlocProvider.of<LayoutCubit>(context).addOrRemoveFromcart(id: BlocProvider.of<LayoutCubit>(context).homeProducts[counter!].id!.toString());
                },color: BlocProvider.of<LayoutCubit>(context).cartIds.contains(BlocProvider.of<LayoutCubit>(context).homeProducts[counter!].id!.toString())? Colors.red : Colors.green,
                  child:
                  BlocProvider.of<LayoutCubit>(context).cartIds.contains(BlocProvider.of<LayoutCubit>(context).homeProducts[counter!].id!.toString())?
                  Text("Remove from cart",style: TextStyle(color: Colors.white),):
                  Text("Add to cart",style: TextStyle(color: Colors.white),)
                )
              ],
            ),
          ),
        )
        );
  }
}
