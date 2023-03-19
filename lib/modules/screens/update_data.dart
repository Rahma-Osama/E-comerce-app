import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';
import 'package:untitled8/layout/layout_cubit/layout_states.dart';
import 'package:untitled8/shared/components/components.dart';
class UpdateData extends StatelessWidget {
   UpdateData({Key? key}) : super(key: key);
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state){},
        builder: (context,state)=>Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          elevation: 0,
          title: const Text("Update Data",)
      ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 120),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 70,
                      child: Icon(Icons.person,color: Colors.green,size: 70,),
                    ),
                    SizedBox(height: 20,),
                    customTextFormField(controller: nameController,  label: "New Name", pref: Icons.account_circle_rounded),
                    SizedBox(height: 20,),
                    customTextFormField(controller: phoneController,  label: "New phone",pref: Icons.phone),
                    SizedBox(height: 20,),
                    MaterialButton(
                      child: const Text("Update"),
                        color: Colors.green,
                        onPressed:(){
                          BlocProvider.of<LayoutCubit>(context).updateUserData(name: nameController.text,phone: phoneController.text);
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          ),
    ),
        );
  }
}
