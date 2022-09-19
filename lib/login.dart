import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components.dart';
import 'Utils.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const Login({Key? key, required this.onClickedSignUp}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'LOGIN',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 60),
        SvgPicture.asset(
          'assets/login.svg',
          height: MediaQuery.of(context).size.height * 0.35,
        ),
        const SizedBox(height: 40),
        Components.textFieldContainer(
          TextField(
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
          ), 
          context
        ),
        const SizedBox(height: 4),
        Components.textFieldContainer(
          TextField(
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
          ),
          context
        ),
        const SizedBox(height: 20),
        Components.roundedButton("Login", signIn, context),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 20),
            text: 'No account?  ',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                text: 'Sign Up',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.deepPurple[200]
                )
              )
            ]
          )
        )
      ],
    ),
  );

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => const Center(child: CircularProgressIndicator())
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch(e) {
      Utils.showSnackBar(e.message);
    }
    
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}