import 'package:flutter/material.dart';

// check if the context is mounted ex: context.mounted == true
extension ContextExtensions on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}
