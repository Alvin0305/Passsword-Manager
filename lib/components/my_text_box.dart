import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  MyTextBox({
    super.key, 
    required this.hintText, 
    required this.controller, 
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        
        style: TextStyle(
          color: Colors.grey[200],
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color(0xFFE0FFFF),
            )
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}