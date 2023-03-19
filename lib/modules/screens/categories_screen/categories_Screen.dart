import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(itemBuilder: (context,index){
        var cubit = BlocProvider.of<LayoutCubit>(context);
        return Container(
          height: 150,
          width: double.infinity,
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(cubit.categories[index].image!,width: 150,height: 150,fit: BoxFit.cover,),
              // SizedBox(width: 20,),
              Text(cubit.categories[index].name!,style: TextStyle(fontWeight: FontWeight.bold),maxLines:3,overflow: TextOverflow.ellipsis,),
              // SizedBox(width: 20,),
              Icon(Icons.arrow_forward_ios)


            ],
          ),
        );
      },
          separatorBuilder:(context,state)=> Divider(
            thickness: 2,
            color: Colors.green,
          ),
          itemCount: BlocProvider.of<LayoutCubit>(context).categories.length! ),
    );
  }
}
