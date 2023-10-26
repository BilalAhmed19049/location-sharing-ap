import 'package:flutter/material.dart';

import '../Widgets/dynamic_elevated_button.dart';
import '../Widgets/dynamic_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('LogIn',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    'assets/3d-render-secure-login-password-illustration.jpg',
                  )),
              CustomTextField(
                labeltext: 'Email',
                controller: emailNameController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                labeltext: 'Password',
                controller: passwordNameController,
              ),
              SizedBox(
                height: 10,
              ),
              DynamicElevatedButton(
                text: 'LOGIN',
                onPress: () {},
              ),
              TextButton(
                onPressed: () {},
                child: Text('Do not have account! Create here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
