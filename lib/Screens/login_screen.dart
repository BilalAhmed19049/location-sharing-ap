import 'package:flutter/material.dart';
import 'package:location_sharing_app/Screens/signup_screen.dart';

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid email';
                  }
                },
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
                onPress: () {
                  if (Form.of(context)!.validate()) {
                    print('please fill fields properly');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'Do not have account! ',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 17, // Set the text color to white
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'SignUp',
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
