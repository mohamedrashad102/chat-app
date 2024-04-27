import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/widgets/def_text_button.dart';
import 'package:chat_app/widgets/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/def_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kprimaryColor,
        body: Container(
          margin: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // scholar image
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(kscholar),
                  ),
                  // scholar chat -> text
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Scholar chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // login -> text
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // email -> text field
                  DefTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                    type: Type.email,
                  ),
                  const SizedBox(height: 10),
                  // password -> text field
                  DefTextFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const SizedBox(height: 10),
                  // login button
                  DefTextButton(
                    'LOGIN',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await login(context);
                      }
                    },
                  ),
                  // don't have an account? sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // don't have an account?
                      const Text(
                        "don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // sign up
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerScreen);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      _emailController.clear();
      _passwordController.clear();
      if (!context.mounted) return;
      Navigator.pushNamed(context, Routes.homeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.', true);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.', true);
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
