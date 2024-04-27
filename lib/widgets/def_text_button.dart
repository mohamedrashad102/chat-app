import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefTextButton extends StatelessWidget {
  DefTextButton(this.txt, {super.key, required this.onPressed});
  String txt;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: MaterialButton(
        textColor: const Color(0xff2B475E),
        onPressed: onPressed,
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
