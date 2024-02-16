

import 'package:firbase_chattapp/Screeens/Home%20Screen.dart';
import 'package:firbase_chattapp/Widget/Uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User SignIn",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          SizedBox(height: 30,),
          Uihelper.CustomTextField(email, "Email", Icons.email),
          Uihelper.CustomTextField(password, "Password", Icons.password),
          Uihelper.CustomTextField(confirm, "Confirm Password", Icons.password),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {
            signin(email.text.toString(), password.text.toString());
          }, child: Text("SignIn"))
        ],
      ),
    );
  }

  signin(String email, String password) async{
    if (email == "" && password == "") {
      return log("Enter Required Fields");

    }
    else{
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) {
          log("User Sign In");
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
    }
  }
}
