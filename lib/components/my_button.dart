import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String text;
  Function()? onTap;

  MyButton({
    super.key, 
    required this.text, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color(0xFF2F4F4F),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Text(
          text, 
          style: TextStyle(
            color: Color(0xFFE0FFFF),
          ),
        ),
      ),
    );
  }
}