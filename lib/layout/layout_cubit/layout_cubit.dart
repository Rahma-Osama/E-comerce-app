import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/models/banner_model.dart';
import 'package:untitled8/models/user_model.dart';
import 'package:untitled8/modules/login_screen.dart';
import 'package:untitled8/modules/screens/favorites_screen/WhishedList_screen.dart';
import 'package:untitled8/modules/screens/cart_screen/cart_screen.dart';
import 'package:untitled8/modules/screens/categories_screen/categories_Screen.dart';
import 'package:untitled8/modules/screens/products/home_screen1.dart';
import 'package:untitled8/modules/screens/profile_screen/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:untitled8/shared/consetennts/const.dart';
import 'package:untitled8/shared/network/local_network.dart';

import '../../models/categories_model.dart';
import '../../models/home_product_model.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(IntialState());
   int bottomNavBarIndex=0;
   changeIndex(index){
     bottomNavBarIndex=index;
     emit(ChangeBottomNavBaerItem());

   }

   List<Widget> screens =[
     HomeScreen1(),
     CategoriesScreen(),
     WhishedScreen(),
     CartScreen(),
     ProfileScreen(),
   ];
    UserModel? userModel;
   getUsersData()async{
     print(token);
     emit(LoadingGetUserData());
     Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/profile'),
     headers: {
       "Authorization" : token!,
       "lang" : "en"
     });
     var responseData=jsonDecode(response.body);
     if(responseData['status']==true){
       userModel = UserModel.fromjson(response: responseData['data']);
       emit(SuccessGetUserData());
       print(token);
       print(userModel!.name);
     }
     else{
       emit(FailedGetUserData());
       print("getting user data error");
     }
   }

   List<BannerModel>  banners=[];
  List<Image> prodectsImgs=[];
  void getBanners()async{
    banners=[];
    prodectsImgs=[];
     emit(LoadingBannerItem());
     Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/banners'));
     var responseData = jsonDecode(response.body);
     if(responseData['status'] == true){
       for(var item in responseData['data']){
         banners!.add(BannerModel.feomjson(item));
         prodectsImgs!.add(Image(image: NetworkImage(BannerModel.feomjson(item).image!,),fit: BoxFit.cover,width: double.infinity,)
         );
       }
       debugPrint("First item is ${banners.first.image}");
       emit(SuccessBannerItem());
     }
     else {
       debugPrint("Failed to load Bannar items");
       emit(FailedBannerItem());
     }
   }

  List<CategoriesrModel>  categories=[];
  void getCategories()async{
    emit(LoadingCategoriesItem());
    Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/categories'),
    headers: {
      "lang" : "en"
    }
    );
    var responseData = jsonDecode(response.body);
    if(responseData['status'] == true){
      for(var item in responseData['data']['data']){
        categories!.add(CategoriesrModel.feomjson(item));
      }
      debugPrint("First item is ${categories.first.image}");
      emit(SuccessCategoriesItem());
    }
    else {
      debugPrint("Failed to load categories items");
      emit(FailedCategoriesItem());
    }
  }

  List<HomeProductModel>  homeProducts=[];
  void getHomeProducts()async{
    emit(LoadingHomeProducts());
    Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/home'),
    headers: {
      "lang" : "en"
    });
    var responseData = jsonDecode(response.body);
    if(responseData['status'] == true){
      for(var item in responseData['data']['products']) {
        homeProducts!.add(HomeProductModel.feomjson(item));


      }
      debugPrint("First item is ${homeProducts.first.image}");
      emit(SuccessHomeProducts());
    }
    else {
      debugPrint("Failed to load Home product items");
      emit(FailedHomeProducts());
    }
  }

  List<HomeProductModel> searchedProducts=[];
  void searchProducts ({required String input}){
    searchedProducts = homeProducts.where((element) => element.name.toString().toLowerCase().startsWith(input.toLowerCase())).toList();
    emit(SuccessSearchState());
  }

  List<HomeProductModel>  favorites=[];
  Future<void> getFavorites()async{
    favorites.clear();
    emit(LoadingFavorites());
    Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {
          "lang" : "en",
          "Authorization" : token!
        });
    var responseData = jsonDecode(response.body);
    if(responseData['status'] == true){
      for(var item in responseData['data']['data']) {
        favorites!.add(HomeProductModel.feomjson(item['product']));


      }
      debugPrint("First item in favorites is ${favorites.first.image}");
      emit(SuccessFavorites());
    }
    else {
      // favorites = [];
      debugPrint("Failed to load favorites");
      emit(FailedFavorites());
    }
  }

  Set<String> favoritesIds ={};
  void  addOrRemoveFromFavorites({required String id})async{
    favorites.clear();
    favoritesIds.contains(id)? favoritesIds.remove(id):favoritesIds.add(id);
    Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: {
        'lang' : 'en',
        'Authorization' : token!
      },
      body: {
        'product_id' : id
      }
    );
    var responseData= jsonDecode(response.body);
    if(responseData['status']==true){
      await getFavorites();
      emit(SuccessaddOrRemoveFromFavorites());
    }
    else emit(FailedaddOrRemoveFromFavorites());
  }

  //Cart

  List<HomeProductModel>  cart=[];
  int total=0;
  Future<void> getCart()async{
    favorites.clear();
    emit(LoadingCart());
    Response response = await http.get(Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {
          "lang" : "en",
          "Authorization" : token!
        });
    var responseData = jsonDecode(response.body);
    if(responseData['status'] == true){
      total=responseData['data']['total'];
      for(var item in responseData['data']['cart_items'])
      {
        cartIds.add(item['product']['id'].toString());
        cart!.add(HomeProductModel.feomjson(item['product']));
      }
      // debugPrint("First item in cart is ${cart.first.image}");
      emit(SuccessCart());
    }
    else {
      cart = [];
      debugPrint("Failed to load cart");
      emit(FailedCart());
    }
  }

  Set<String> cartIds ={};
  void  addOrRemoveFromcart({required String id})async{
    cart.clear();
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {
          'lang' : 'en',
          'Authorization' : token!
        },
        body: {
          'product_id' : id
        }
    );
    var responseData= jsonDecode(response.body);
    if(responseData['status']==true)
    {
      cartIds.contains(id)? cartIds.remove(id):cartIds.add(id);
      await getCart();
      emit(SuccessaddOrRemoveFromCart());
    }
    else emit(FailedaddOrRemoveFromCart());
  }

  void updateUserData({required String name, required String phone})async{
    emit(LoadingUpdateUserData());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.put( Uri.parse('https://student.valuxapps.com/api/update-profile'),
    body: {
      'name' : name,
      'email' : userModel!.email,
      'password' : currentPassword,
      'phone' : phone,

    },
      headers: {
        'Authorization' : token!
      }
    );

    var responseBody = jsonDecode(response.body);
    if(responseBody['status']){
      userModel = UserModel.fromjson( response: responseBody['data']);
      emit(SuccessUpdateUserData());
    }
    else{
      emit(FailedUpdateUserData());
    }
  }

  void logOut(context)
  {
    favoritesIds.clear();
    cartIds.clear();
    cart.clear();
    favorites.clear();
    userModel = null;
    bottomNavBarIndex=0;
    CacheNetwork.deleteCacheData(key: "token");
    Navigator.pushReplacement( context , MaterialPageRoute(builder: (context)=>LogIn()));
    emit(logoutSuccessfully());
  }

}