import 'package:flutter/material.dart';

class DynamicElevatedButton extends StatelessWidget {
  const DynamicElevatedButton(
      {super.key, required this.text, required this.onPress});

  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onPress,
          child: Text(text, style: TextStyle(
            color: Colors.white,
          )),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          )
      ),
    );
  }
}
