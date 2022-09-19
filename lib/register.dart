import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hackernews/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components.dart';
import 'Utils.dart';

class Register extends StatefulWidget {
  final Function() onClickedSignIn;
  const Register({Key? key, required this.onClickedSignIn}) : super(key: key);
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(60),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'SIGN UP',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 60),
          SvgPicture.asset(
            'assets/signup.svg',
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          const SizedBox(height: 40),
          Components.textFieldContainer(
            TextFormField(
              controller: emailController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.deepPurple[300],
                ),
                hintText: 'Email',
                border: InputBorder.none
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) => 
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email' : null,
            ), 
            context
          ),
          const SizedBox(height: 4),
          Components.textFieldContainer(
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.deepPurple[300],
                ),
                hintText: 'Password',
                border: InputBorder.none
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => 
                  password != null && password.length < 8
                      ? 'Enter min 8 characteres' : null,
            ),
            context
          ),
          const SizedBox(height: 20),
          Components.roundedButton("Sign up", signUp, context),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 20),
              text: 'Already have an account?  ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
                  text: 'Log in',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.deepPurple[200],
                  )
                )
              ]
            )
          )
        ],
      ),
    ),
  );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => const Center(child: CircularProgressIndicator())
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}