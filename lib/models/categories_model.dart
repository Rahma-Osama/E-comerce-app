import 'package:flutter/foundation.dart';

class CategoriesrModel{
  int? id;
  String? image;
  String? name;

  CategoriesrModel.feomjson(Map<String,dynamic> response){
    id=response['id'];
    image=response['image'];
    name=response['name'];
  }
}