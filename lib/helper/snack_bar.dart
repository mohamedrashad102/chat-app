import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context,
  String text,
  bool isError,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
