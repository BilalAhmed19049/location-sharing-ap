import 'package:flutter/material.dart';

import '../Widgets/dynamic_elevated_button.dart';
import '../Widgets/dynamic_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('SignUp',
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
                labeltext: 'First Name',
                controller: firstNameController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                labeltext: 'Last Name',
                controller: lastNameController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                labeltext: 'Email',
                controller: emailController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                labeltext: 'Password',
                controller: passwordController,
              ),
              SizedBox(
                height: 10,
              ),
              DynamicElevatedButton(
                text: 'SIGNUP',
                onPress: () {},
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Already have an account! ',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17, // Set the text color to white
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'LogIn',
                        style: TextStyle(
                          color: Colors
                              .deepPurple, // Set the text color to deep purple
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
