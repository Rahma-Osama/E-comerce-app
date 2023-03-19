class UserModel{
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserModel.fromjson({required Map<String,dynamic> response}){
    name=response['name'];
    email=response['email'];
    phone=response['phone'];
    image=response['image'];
    token=response['token'];
  }

  Map<String,dynamic> toMap(){
    return{
      "name" :name,
      "email" :email,
      "phone" :phone,
      "image" :image,
      "token" :token,
    };
  }
}