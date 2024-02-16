import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbase_chattapp/Screeens/Fetch%20Data.dart';
import 'package:firbase_chattapp/Screeens/Home%20Screen.dart';
import 'package:firbase_chattapp/Screeens/SignIn.dart';
import 'package:firbase_chattapp/Screeens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
Timer(Duration(seconds: 3), () {
  isLoggedin();
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:  Center(child: Icon(Icons.message,color: Colors.blue,size: 50),),
    );
  }

  isLoggedin(){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));


    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));

    }

  }
}
