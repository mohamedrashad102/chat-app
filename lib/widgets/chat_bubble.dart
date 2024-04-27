import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
  });

  final String message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final double paddingSize = MediaQuery.of(context).size.width * .2;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(
          left: isSender ? paddingSize : 0,
          right: isSender ? 0 : paddingSize,
        ),
        decoration: BoxDecoration(
          color: isSender ? kprimaryColorSender : kprimaryColorReceiver,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSender ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
