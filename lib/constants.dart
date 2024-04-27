import 'package:flutter/material.dart';

const String kscholar = 'assets/images/scholar.png';

const Color kprimaryColor = Color.fromARGB(255, 55, 84, 108);
const Color kprimaryColorSender = Color(0xff2B475E);
const Color kprimaryColorReceiver = Color.fromARGB(255, 61, 99, 130);

String? emailValidator(String? data) {
  if (data == null || data.isEmpty) return 'you should enter email';
  if (!data.contains('@')) return 'enter correct email';
  return null;
}

String? passwordValidator(String? data) {
  if (data == null || data.isEmpty) return 'you should enter password';
  if (data.length < 8) return 'password must be more than or equal 8';
  return null;
}
