// import 'package:code_app/modules/boarding_screen.dart';
// import 'package:untitled8//modules/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/bloc_observer.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_screen.dart';
import 'package:untitled8/modules/cubit/cubit.dart';
import 'package:untitled8/modules/cubit/states.dart';
import 'package:untitled8/modules/login_screen.dart';
import 'package:untitled8/modules/screens/products/home_screen1.dart';
import 'package:untitled8/modules/screens/update_data.dart';
import 'package:untitled8/modules/splash_screen.dart';
import 'package:untitled8/shared/consetennts/const.dart';
import 'package:untitled8/shared/network/local_network.dart';
import 'modules/boarding_screen.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cachInstialization();
  token=  await CacheNetwork.getCacheData(key: "token");
  print("tokkkkeeeeeennnnn : $token");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx)=>AuthCubit(),),
        BlocProvider(create: (ctx)=>LayoutCubit()..getBanners()..getCategories()..getHomeProducts()..getUsersData()..getFavorites()..getCart()
          ,)
      ],
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (ctx,state){},
        builder: (ctx,state)=>MaterialApp(
            debugShowCheckedModeBanner: false,
            home:LogIn()
             // token!= null || token!="Null "? LayoutScreen() :SplashScreen()
        ),
      ),
    );
  }
}
