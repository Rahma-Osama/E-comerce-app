import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/layout_cubit/layout_cubit.dart';
import '../../../layout/layout_cubit/layout_states.dart';

class WhishedScreen extends StatelessWidget {
  const WhishedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =BlocProvider.of<LayoutCubit>(context);
    // cubit.getFavorites();
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context , listner){
          if(State is LoadingFavorites){
            Center(child: CircularProgressIndicator(color: Colors.green,));
          }
        },
        builder: (context,listner)=> cubit.favorites.isEmpty ?Center(child: CircularProgressIndicator(color: Colors.green,))
        : ListView.separated(
            itemBuilder: (context,index)=>Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[100],
          child: Row(
            children: [
              Expanded(child: Image.network(cubit.favorites[index].image!,)),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cubit.favorites[index].name!,style: TextStyle(fontWeight: FontWeight.bold),maxLines:3,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 10,),
                    Text(cubit.favorites[index].price!.toString()+ " \$",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    SizedBox(height: 10,),
                    MaterialButton(onPressed: (){
                      cubit.addOrRemoveFromFavorites(id: cubit.favorites[index].id!.toString());
                    },color: Colors.red,child:Text("Remove from favorites",style: TextStyle(color: Colors.white),),)
                  ],
                ),
              )
            ],
          ),
            ),
            separatorBuilder: (context,state)=>Divider(thickness: 2,color: Colors.green,),
            itemCount: cubit.favorites.length)

    );
  }
}
