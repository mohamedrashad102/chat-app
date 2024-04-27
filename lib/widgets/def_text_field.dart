import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Type { normal, email, arabic, english }

// ignore: must_be_immutable
class DefTextFormField extends StatefulWidget {
  const DefTextFormField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.type = Type.normal,
    this.suffixIcon,
    this.prefixIcon,
  });
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final Type type;

  @override
  State<DefTextFormField> createState() => _DefTextFormFieldState();
}

class _DefTextFormFieldState extends State<DefTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword ? (obscureText) : false,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: Colors.white,
      ),
      inputFormatters: [
        getCurrentTextInputFormatter(widget.type),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: const OutlineInputBorder(),
      ),
    );
  }

  getCurrentTextInputFormatter(Type type) {
    TextInputFormatter? textInputFormatter;
    switch (type) {
      case Type.arabic:
        textInputFormatter = FilteringTextInputFormatter.allow(
            RegExp('[\u0600-\u06FF ]')); // Only Arabic letters and spaces
        break;
      case Type.english:
        textInputFormatter = FilteringTextInputFormatter.allow(
            RegExp('[a-z A-Z]')); // Only English letters
        break;
      case Type.email:
        textInputFormatter =
            FilteringTextInputFormatter.allow(RegExp('[a-z0-9.@]'));
        break;
      default:
        textInputFormatter = FilteringTextInputFormatter.singleLineFormatter;
        break;
    }
    return textInputFormatter;
  }
}
