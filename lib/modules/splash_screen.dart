// import 'package:code_app/modules/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/modules/boarding_screen.dart';
import 'package:untitled8/modules/login_screen.dart';
import 'package:untitled8/modules/screens/products/home_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BoardingScreen()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Fashion Store",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color:Colors.green),),
      ),
    );
  }
}

