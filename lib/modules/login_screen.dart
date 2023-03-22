import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_screen.dart';
import 'package:untitled8/modules/cubit/cubit.dart';
import 'package:untitled8/modules/cubit/states.dart';
import 'package:untitled8/modules/screens/products/home_screen1.dart';
import 'package:untitled8/modules/sign_up_screen.dart';

import '../shared/components/components.dart';
class LogIn extends StatelessWidget {
   LogIn({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit ,AuthStates> (
      listener: (context, state){
        if(state is LogInSuccessState){
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
        }

        else if(state is LogInFailedState){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar (message: state.message!)
          );
        }else{
        showDialog(context: context, builder: (_)=>AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.green,),
            SizedBox(width: 10,),
            Text("Loading..")
          ],
        ),
        ));
        }
      },
      builder: (context,state)=>Scaffold(
        backgroundColor: Colors.green,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: customHeadingText(text: "LOGIN"
                ),
                  ),
                ),
                Container(
                  height: 800,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                  ),
                  child: Column(

                    children: [
                      SizedBox(height: 80,),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child:customTextFormField(controller: emailController,
                            pref: Icons.email,
                            label: "email"
                        ) ,
                      ),

                      Padding(
                        padding:  const EdgeInsets.all(12),
                        child:customTextFormField(controller: passwordController,
                            pref: Icons.remove_red_eye,
                            label: "password",
                            isobsecure: true
                        ) ,
                      ),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: customButton(text: "Sign In", fun: ()async{
                          if(formKey.currentState!.validate()){
                            BlocProvider.of<AuthCubit>(context).logIn(email: emailController.text, password: passwordController.text);
                           await BlocProvider.of<LayoutCubit>(context).getUsersData();
                          }
                        }),
                      ),
                      SizedBox(height: 15,),
                      // customButton(text: "Sign in with Google", fun: (){
                      //
                      //
                      // }),
                      SizedBox(height: 20,),
                      Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( "Don't have an account?",style: TextStyle(color: Colors.grey[600],fontSize: 16)),
                                InkWell(child: Text("..Create One",style: TextStyle(color: Colors.green, fontSize: 16)),
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                  },),

                              ]
                          )
                      )

                    ],
                  ),
                )



              ],
            ),
          ),
        ),
      )


    );
  }
}
