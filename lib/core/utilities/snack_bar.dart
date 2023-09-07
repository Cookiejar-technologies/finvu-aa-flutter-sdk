import 'package:flutter/material.dart';

class AppSnackBar{
  
  static show(String msg, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg),
      )
    );
  }
  
}