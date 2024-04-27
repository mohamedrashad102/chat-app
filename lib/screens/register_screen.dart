import 'package:chat_app/helper/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/def_text_button.dart';
import '../widgets/def_text_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  Image.asset(kscholar),
                  // scholar chat -> text
                  const Text(
                    'Scholar chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: 23,
                    ),
                  ),
                  // login -> text
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                    validator: passwordValidator,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  // register button
                  DefTextButton(
                    'REGISTER',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await register(context);
                      }
                    },
                  ),
                  // don't have an account? sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // don't have an account?
                      const Text(
                        "already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // sign up
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      _emailController.clear();
      _passwordController.clear();
      if (context.mounted) {
        showSnackBar(
          context,
          'Account successfully created',
          false,
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      if (e.code == 'weak-password') {
        showSnackBar(
          context,
          'The password provided is too weak.',
          true,
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          'The account already exists for that email.',
          true,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, 'error: ${e.toString()}', true);
    }
    setState(() {
      isLoading = false;
    });
  }
}
