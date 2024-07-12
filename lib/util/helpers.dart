import 'package:flutter/material.dart';

class Helpers {
  static RegExp get emailRegExp => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp get phoneRegExp => RegExp(r'^\+\d{11,}$');
  static RegExp get passwordPattern => RegExp(r'^[a-zA-Z0-9]+$');

  static RegExp get letterPattern => RegExp(r'[a-zA-Z ]');

  static String? registerValidator(BuildContext context, String? value, bool isPassword) {
    if (value == null || value.isEmpty) {
      return 'Field cannnot be empty';
    }
    if (!Helpers.emailRegExp.hasMatch(value) && !isPassword) {
      return 'Please, enter a valid email address';
    }
    if (!Helpers.passwordPattern.hasMatch(value) && isPassword) {
      return 'Password can only contain letters and numbers';
    }

    return null;
  }

  static String? fieldValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannnot be empty';
    }

    return null;
  }
}
