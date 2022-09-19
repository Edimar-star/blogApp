import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  
  @override
  Widget build(BuildContext context) => isLogin 
      ? Login(onClickedSignUp: toggle)
      : Register(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}