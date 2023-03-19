import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/modules/cubit/cubit.dart';
import 'package:untitled8/modules/cubit/states.dart';
import 'package:untitled8/shared/components/components.dart';

import 'login_screen.dart';
class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
final nameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final passwordController = TextEditingController();
var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state){
        if(state is RegisterSuccessState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
        }
        else if(state is RegisterFailedState){
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(message: state.message!)
        );
            }
      },
      builder: (context,state)=>Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(12),
                  height: 100,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("REGISTER..",
                      style: TextStyle(

                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40
                      ),),
                  ),
                ),

              Container(
                height: 800,
                decoration: BoxDecoration(

                  color: Colors.white
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child:customTextFormField(controller: nameController,
                          pref: Icons.person,
                          label: "name"
                      ) ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child:customTextFormField(controller: phoneController,
                          pref: Icons.phone,
                          label: "phone number"
                      ) ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child:customTextFormField(controller: emailController,
                          pref: Icons.email,
                          label: "email"
                      ) ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child:customTextFormField(controller: passwordController,
                          pref: Icons.remove_red_eye,
                          label: "password",
                          isobsecure: true
                      ) ,
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: customButton(text: "Sign Up", fun: (){
                          if(formKey.currentState!.validate()){
                            BlocProvider.of<AuthCubit>(context).register(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text);
                          }
                        }),
                      ),
                    ),
                    
                    Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( "Already havean account?",style: TextStyle(color: Colors.grey[600],fontSize: 16)),
                              InkWell(child: Text("..Sign in",style: TextStyle(color: Colors.green, fontSize: 16)),
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
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
