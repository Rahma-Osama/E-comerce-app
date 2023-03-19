import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/models/home_product_model.dart';
import 'package:untitled8/modules/screens/categories_screen/categories_layout.dart';
import 'package:untitled8/modules/screens/products/product_details.dart';
import 'package:untitled8/modules/screens/products/products_screen.dart';

import '../../../shared/components/components.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (ctx , state){},
        builder: (ctx , state) =>  SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Colors.grey[200],
                height: 200,
                width: double.infinity,
                child: BlocProvider.of<LayoutCubit>(context).prodectsImgs.isEmpty? loadingCarousel():CarouselSlider(
                  items: BlocProvider.of<LayoutCubit>(context).prodectsImgs  ,
                  options: CarouselOptions(
                   viewportFraction: 1,
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),

              ),
              SizedBox(height: 20,),
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18
                      ),),
                      InkWell(
                          onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesLayout()));
                          },
                          child: Text("View All"))
                    ],
                  ),
              SizedBox(
                height: 100,
                child:  BlocProvider.of<LayoutCubit>(context).categories!.isEmpty?loadingCategories():ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,counter)=> Padding(
                    padding: const EdgeInsets.only(top: 8,right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(BlocProvider.of<LayoutCubit>(context).categories![counter].image!),
                      backgroundColor: Colors.grey[200],
                      radius: 35,

                    ),
                  ),
                  itemCount: BlocProvider.of<LayoutCubit>(context).categories!.length,),
              ),
              SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Products", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18
                ),),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsSceen()));
                    },
                    child: Text("View All"))
              ],
            ),          Container(color: Colors.green,),
            SizedBox(height: 20,),
              BlocProvider.of<LayoutCubit>(context).homeProducts!.isEmpty? customLoadingGrid():GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .7,
                    crossAxisCount: 2
                ), itemBuilder: (context,counter) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(height: 500,width: 50, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(counter: counter)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.centerRight ,child: IconButton(onPressed: (){
                        BlocProvider.of<LayoutCubit>(context).addOrRemoveFromFavorites(id: BlocProvider.of<LayoutCubit>(context).homeProducts![counter].id!.toString());
                      }, icon: Icon( Icons.favorite,
                        color: BlocProvider.of<LayoutCubit>(context).favoritesIds!.contains(BlocProvider.of<LayoutCubit>(context).homeProducts![counter].id!.toString()) ?
                      Colors.red : Colors.grey,)  )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(width: 150,height: 100,child: Image.network(BlocProvider.of<LayoutCubit>(context).homeProducts![counter].image!,
                         )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${BlocProvider.of<LayoutCubit>(context).homeProducts![counter].name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(textAlign: TextAlign.start,"${BlocProvider.of<LayoutCubit>(context).homeProducts![counter].price} \$",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                        ),
                      )
                    ],
                  ),
                ),
                )),itemCount: BlocProvider.of<LayoutCubit>(context).homeProducts!.length,)

            ],
          ),
        ),
        ) );


  }
}
