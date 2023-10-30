import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/dynamic_elevated_button.dart';
import '../Widgets/dynamic_textfield.dart';

class SignupScreen extends StatelessWidget {
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
              // CustomTextField(
              //   labeltext: 'First Name',
              //   controller: firstNameController,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextField(
              //   labeltext: 'Last Name',
              //   controller: lastNameController,
              // ),
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
                onPress: () {
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please fill in all fields.'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      signUp();

                      // CreateData().createUser(FirebaseModel(
                      //     email: email,
                      //     password: password, firstname: '', lastname: ''));
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                    } catch (error) {
                      print(error);
                    }
                  }
                },
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

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      print(error);
    }
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => SignupScreen(),
    //     ));
  }
}
