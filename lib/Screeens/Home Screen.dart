import 'dart:io';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_chattapp/Screeens/Fetch%20Data.dart';
import 'package:firbase_chattapp/Screeens/SignIn.dart';
import 'package:firbase_chattapp/Widget/Uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? PickedImage;
  TextEditingController titlee=TextEditingController();
  TextEditingController descriptionn=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        centerTitle: true,
        actions: [
          IconButton.outlined(onPressed: () {
            logOut();
          }, icon: Icon(Icons.logout_sharp))
        ],

      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              alert();



            },
            child: PickedImage!=null?CircleAvatar(
              radius:  50,
              backgroundImage: FileImage(PickedImage!),

            ):CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
            )
          ),
          SizedBox(height: 40,),
          Uihelper.CustomTextField(titlee, "Title", Icons.title),
          Uihelper.CustomTextField(descriptionn, "Description", Icons.description),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: () {
           auth(titlee.text.toString(), descriptionn.text.toString());
          }, child: Text("Upload"))
        ],
      ),
    );
  }
  alert(){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
           children: [
             ListTile(
               onTap: () {
pickimage(ImageSource.camera);
               },
               leading: Icon(Icons.camera_alt_outlined),
               title: Text("Camera"),

             ),
             ListTile(
               onTap: () {
pickimage(ImageSource.gallery);
               },
               leading: Icon(Icons.browse_gallery),
               title: Text("Gallery"),
             )
           ],
        ),
      );

    },);

  }
      pickimage(ImageSource imageSource)async{
    final photo=await ImagePicker().pickImage(source: imageSource);
try {
  if (photo == "")
    return;
  else {
    final tempImage = await File(photo!.path);

    setState(() {
      PickedImage = tempImage;
    });
  }
}
 catch(ex){
  return log(ex.toString());
        }

      }

      auth(String title,String description){
if(title==""&& PickedImage==""){
  return log("enter Required Fields");
}
else{
  uploadImage();

}


      }
  uploadImage()async{
    UploadTask uploadTask= FirebaseStorage.instance.ref("Image").child(FirebaseAuth.instance.currentUser!.email.toString()).putFile(PickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String imageUrl=await taskSnapshot.ref.getDownloadURL();
    String title= titlee.text.toString();
    String desc=descriptionn.text.toString();

    FirebaseFirestore.instance.collection("Data").doc(FirebaseAuth.instance.currentUser!.email).set(
        {
          "ImageName":imageUrl,
          "Title":title,

          "Decs":desc,
        }).then((value){
      return log("DataUploaded");
    });
Navigator.push(context, MaterialPageRoute(builder: (context) => Fetch(),));
  }

  logOut(){
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => SignIn(),));
    });
  }
}
