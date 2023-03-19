import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/modules/screens/products/product_details.dart';

import '../../../shared/components/components.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
     var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context , state){},
        builder: (context,state)=>Scaffold(
        appBar: AppBar(
          // leading: IconButton(onPressed: (){BlocProvider.of<LayoutCubit>(context).searchedProducts=[];Navigator.pop;},icon: Icon(Icons.arrow_back),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: Text("Search",)
        ),
        body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

        children :[
        SizedBox(
        height: 50,
        child: customsearchField(controller: searchController, fun: (value){
        BlocProvider.of<LayoutCubit>(context).searchProducts(input: value);
        }),
    ),
    Expanded(
    child: BlocProvider.of<LayoutCubit>(context).searchedProducts! .isNotEmpty ? GridView.builder(
    itemCount: BlocProvider.of<LayoutCubit>(context).searchedProducts!.length ,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2

    ), itemBuilder: (BuildContext context, int index) =>Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 500,width: 50, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(counter: index)));
        },
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerRight ,child: IconButton(onPressed: (){
            BlocProvider.of<LayoutCubit>(context).addOrRemoveFromFavorites(id: BlocProvider.of<LayoutCubit>(context).homeProducts![index].id!.toString());
          }, icon: Icon( Icons.favorite,
            color: BlocProvider.of<LayoutCubit>(context).favoritesIds!.contains(BlocProvider.of<LayoutCubit>(context).homeProducts![index].id!.toString()) ?
            Colors.red : Colors.grey,)  )),      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(width: 150,height: 50,child: Image.network(BlocProvider.of<LayoutCubit>(context).searchedProducts![index].image!,
        )),
        ),
        Expanded(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${BlocProvider.of<LayoutCubit>(context).searchedProducts![index].name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
        ),
        ),
        Expanded(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(textAlign: TextAlign.start,"${BlocProvider.of<LayoutCubit>(context).searchedProducts![index].price} \$",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
        ),
        ),]),
      ),

      ),
    )
    ) : Container()
    ),
    ]
    ),
    ),
    )
    );
  }
}
