import 'package:flutter/material.dart';

class CommonUtils {
  static void navigate(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
