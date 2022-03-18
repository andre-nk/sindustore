import 'package:flutter/material.dart';

class MQuery {
  static double height(double ratio, BuildContext context){
    return MediaQuery.of(context).size.height * ratio;
  }

  static double width(double ratio, BuildContext context){
    return MediaQuery.of(context).size.width * ratio;
  }
}