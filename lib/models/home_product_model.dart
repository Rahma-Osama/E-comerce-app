class HomeProductModel{
  int?id;
  int? price;
  String? image;
  String? name;
  String? description;
  // bool inFavorite=false;
  // bool inCart=false;

  HomeProductModel.feomjson(Map<String,dynamic> response){
    id=response['id'];
    price=response['price'].toInt();
    image=response['image'];
    name=response['name'];
    description=response['description'];
    // inCart=response['in_cart'];
    // inFavorite=response['in_favorites'];
  }
}