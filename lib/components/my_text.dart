import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  final String text;

  MyText({
    super.key, 
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: TextStyle(
        color: Colors.grey[200], 
        fontSize: 20,
      ),
    );
  }
}