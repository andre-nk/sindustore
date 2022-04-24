import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteWrapper {
  static Future push(BuildContext context, {required Widget child}) {
    return Navigator.push(
      context,
      PageTransition(
        curve: Curves.bounceOut,
        opaque: true,
        type: PageTransitionType.rightToLeftWithFade,
        child: child,
      ),
    );
  }
}
