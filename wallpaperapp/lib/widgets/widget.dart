import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BrandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text("Wallpaper",style: TextStyle(color: Colors.pink),),
    Text("App",style: TextStyle(color: Colors.black),),
  ],
  );
}
