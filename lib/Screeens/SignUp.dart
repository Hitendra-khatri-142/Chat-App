import 'package:firbase_chattapp/Screeens/SignIn.dart';
import 'package:firbase_chattapp/Widget/Uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Center(child: Text(
            "SignUp", style: TextStyle(color: Colors.blue, fontSize: 30),)),
          SizedBox(height: 20,),
          Uihelper.CustomTextField(email, "Email", Icons.email),
          Uihelper.CustomTextField(password, "Password", Icons.password),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
signUp(email.text.toString(), password.text.toString());
              }, child: Text("SignUp")),
            SizedBox(width: 20,),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
            }, child: Text("SignIn"))
            
            ],
          )

        ],
      ),
    );
  }
  signUp(String email,String password)async{
    if(email=="" && password==""){
      return log("enter required fields");
    }
    else {
      UserCredential ? userCredential;
      try {
        userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password).then((value) {
          log("user Created");
        });
      }
      on FirebaseAuthException catch(ex){
        return log(ex.code.toString());
      }
    }



  }

}
