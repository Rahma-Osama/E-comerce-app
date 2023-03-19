import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:untitled8/modules/cubit/states.dart';
import 'package:http/http.dart' as http;
import 'package:untitled8/shared/network/local_network.dart';

import '../../shared/consetennts/const.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(IntialState());

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async{
    emit(RegisterLoadingState());
   try {
     Response response = await http.post(
         Uri.parse('https://student.valuxapps.com/api/register'),
         body: {
           'name': name,
           'email': email,
           'password': password,
           'phone': phone
         },
       headers: {
         'lang': "en"
       },

     );
     if(response.statusCode==200){
       var data = jsonDecode(response.body);
       if(data['status']==true){
         print("Response is : $data");
         emit(RegisterSuccessState());
       }
       else {
         print("Response is : $data");
         emit(RegisterFailedState(message: data['message']));
       }

     }
   }catch(e){
     emit(RegisterFailedState(message: "Something went wrong , Try again later "));
     print("error : ${e.toString()}");
   }
  }
  void logIn({
  required String email,
    required String password,

})async{
    emit(LogInLoadingState());
    try{
      Response response = await http.post(Uri.parse('https://student.valuxapps.com/api/login'),
          headers: {
            'lang': "en"
          },
          body: {
            'email': email,
            'password': password,
          }
      );
      if(response.statusCode==200 ){
        var responseData = jsonDecode(response.body);
        if(responseData['status'] == true){
          await CacheNetwork.insertToCashe(key: "token", value: responseData['data']['token']);
          await CacheNetwork.insertToCashe(key: "password", value:password);
          emit(LogInSuccessState());
          debugPrint("LogIN Succcessfully , token is : ${token}");
        }
        else{
          emit(LogInFailedState(message: responseData['message']));
          debugPrint("Failed to LogIn : $responseData['message]");

        }
      }
    }catch(e){
      emit(LogInFailedState(message :"Something went wrong , Try again later "));
    }
  }


}


