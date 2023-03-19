class BannerModel{
  int? id;
  String? image;
  String? category;
  String? product;

  BannerModel.feomjson(Map<String,dynamic> response){
    id=response['id'];
    image=response['image'];
    category!=response['category'];
    product=response['product'];
  }
}