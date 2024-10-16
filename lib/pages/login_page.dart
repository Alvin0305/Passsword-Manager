import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';
import 'package:password_app/pages/first_page.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _pwController = TextEditingController();
  final myPassword = Hive.box('password_data');
  final dataBox = Hive.box('data');

  void onTap(BuildContext context) {
    String enteredPW = _pwController.text;
    if (enteredPW == dataBox.get('password')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstPage(),
        )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Who are you"
          )
        )
      );
    }
  }

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Color(0xFF2F4F4F),
        title: Text(
          "L O G I N  P A G E", 
          style: TextStyle(
            color: Colors.grey[200],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.key, 
              size: 64,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16,),
            Text(
              "Hi ${dataBox.get('name')}!", 
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16,),
            MyTextBox(
              hintText: "Password...", 
              controller: _pwController, 
              obscureText: true,
            ),
            MyButton(
              text: "LOG IN", 
              onTap: () => onTap(context),
            ),
          ],
        ),
      ),
    );
  }
}