import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled8/layout/layout_cubit/layout_cubit.dart';

Widget customHeadingText({required String text}) {
  return Text("$text",
    style: TextStyle(

      decoration: TextDecoration.underline,
        color: Colors.white,
        // fontWeight: FontWeight.bold,
        fontSize: 40
    ),);
}
  Widget customTextFormField({
  required controller,
    required pref,
    required label,
    bool isobsecure = false

  }
      ){
    return TextFormField(
      obscureText: isobsecure,
      cursorColor: Colors.green,
      controller: controller ,
      validator: (String ? value){
        if(value ==null || value.isEmpty){
          return "required";
        }
        else return null;
      },
      decoration: InputDecoration(

          prefixIcon: Icon(pref,color: Colors.grey,),
          label: Text("$label",style: TextStyle(
              color: Colors.grey
          ),),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder()
      ),
    );
  }

  Widget customButton({
  required text,
    required fun()
}){
  return InkWell(
    child: Container(
      width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
         alignment: Alignment.center,
        child: Text("$text",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20)
        ),
    ),
    onTap: fun,
  );
  }

  SnackBar customSnackBar({
  required String message
}){
  return SnackBar(
    content: Container(
        alignment: Alignment.center,
        height: 40,
        child: Text(message,
          style: TextStyle(
              fontSize: 16
          ),
        )
    ),
  );
  }

Widget customsearchField({
  required controller,
  required fun,
  pref = Icons.search,
  suffix= Icons.clear ,
  hint =  "What's in your mind ?",
  // bool isobsecure = false

}
    ){
  return TextFormField(
    // obscureText: isobsecure,
    cursorColor: Colors.green,
    controller: controller ,
     onChanged: fun,
    decoration: InputDecoration(

        prefixIcon: Icon(pref,color: Colors.grey,),
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey
        ),
        border: OutlineInputBorder(

          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        focusedBorder: OutlineInputBorder(
        ),
      filled: true,
      fillColor: Colors.grey.withOpacity(.1)
    ),
  );
}

Widget customLoadingGrid(){
  return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: .7,
      crossAxisCount: 2
  ), itemBuilder:(context , counter)=> Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: Container(
      height: 200,
      width: double.infinity,
      color: Colors.transparent,
    ),

  ));
}
Widget loadingCategories(){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context,counter)=> Padding(
      padding: const EdgeInsets.only(top: 8,right: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child:CircleAvatar(radius: 35,)
      )
    ),
    itemCount: 5,);
}
Widget loadingCarousel(){
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: Container(
      height: 200,
      width: double.infinity,
      color: Colors.transparent,
    ),
  );

}


Widget profileOptiosLayout({
  required IconData icon,
  required String title,
}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(10),
    ),
    height: 50,
    width: double.infinity,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(icon,size: 30,color: Colors.grey[800],),
        ),
        Text("$title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey[800]))
      ],
    ),
  );
}
//if(formKey.currentState!.validate()){
//           BlocProvider.of<AuthCubit>(context).register(
//               name: nameController.text,
//               email: emailController.text,
//               phone: phoneController.text,
//               password: passwordController.text);
//         }