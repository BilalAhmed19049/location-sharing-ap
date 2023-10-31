import 'package:flutter/cupertino.dart';
import 'package:location_sharing_app/Screens/login_screen.dart';
import 'package:location_sharing_app/Screens/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin ? LoginScreen() : SignupScreen();
  }

// void toggle() => setState(() {
//       isLogin = !isLogin;
//     });
}
