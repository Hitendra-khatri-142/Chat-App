import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  Uihelper{
  static CustomTextField(TextEditingController controller,String text,IconData iconData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )

        ),
      ),
    );

  }
}