import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';

import '../../../layout/layout_cubit/layout_cubit.dart';
class ProductsSceen extends StatelessWidget {
  const  ProductsSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,State){},
        builder: (contex,state){
          var cubit = BlocProvider.of<LayoutCubit>(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                elevation: 0,
                title: Text("Products",),
              ),
              body:  ListView.separated(
                  itemBuilder: (context,index)=>Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: Row(
                      children: [
                        Expanded(child: Image.network(cubit.homeProducts[index].image!)),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(cubit.homeProducts[index].name!,style: TextStyle(fontWeight: FontWeight.bold),maxLines:3,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 10,),
                              Text(cubit.homeProducts[index].price!.toString()+ " \$",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                              SizedBox(height: 10,),
                              MaterialButton(onPressed: (){
                                cubit.addOrRemoveFromFavorites(id: cubit.homeProducts[index].id!.toString());
                              },color: BlocProvider.of<LayoutCubit>(context).favoritesIds!.contains(BlocProvider.of<LayoutCubit>(context).homeProducts![index].id!.toString()) ?
                              Colors.red : Colors.green,
                                child:
                                BlocProvider.of<LayoutCubit>(context).favoritesIds!.contains(BlocProvider.of<LayoutCubit>(context).homeProducts![index].id!.toString()) ?
                                Text("Remove from favorites",style: TextStyle(color: Colors.white),): Text("Add to favorites",style: TextStyle(color: Colors.white),),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (context,state)=>Divider(thickness: 2,color: Colors.green,),
                  itemCount: cubit.homeProducts.length)

          );
        });
  }
}
