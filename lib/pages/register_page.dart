import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({
    super.key
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController pwController = TextEditingController();

  final TextEditingController confirm_pwController = TextEditingController();

  final dataBox = Hive.box('data');

  bool setPWVisible = true;
  bool setConfimedPWVisible = true;

  void register() {
    String name = nameController.text;
    String pw = pwController.text;
    String confirmed = confirm_pwController.text;
    if (pw == confirmed) {
      dataBox.put('name', name);
      dataBox.put('password', pw);

      nameController.clear();
      pwController.clear();
      confirm_pwController.clear();
      Navigator.pushNamed(context, '/first');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords are not the same'),
        )
      );
    }
  }

  void showPW() {
    setState(() {
      setPWVisible = !setPWVisible;
    });
  }

  void showConfirmed() {
    setState(() {
      setConfimedPWVisible = !setConfimedPWVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Color(0xFF2F4F4F),
        title: Text(
          'R E G I S T E R  P A G E' , 
          style: TextStyle(
            color: Color(0xFFE0FFFF),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFE0FFFF),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome!!", 
              style: TextStyle(
                color: Color(0xFFE0FFFF),
                fontSize: 32,
              ),
            ),
            MyTextBox(
              hintText: "Enter your Name", 
              controller: nameController, 
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[200],
                ),
                controller: pwController,
                obscureText: setPWVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  suffix: GestureDetector(
                    onTap: showPW,
                    child: Icon(
                      Icons.remove_red_eye, 
                      color: Colors.grey[200],
                    ),
                  ),
                  hintText: "Enter your password",
                  hintStyle: TextStyle(
                    color: Colors.grey[200],
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[200],
                ),
                controller: confirm_pwController,
                obscureText: setConfimedPWVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  suffix: GestureDetector(
                    onTap: showConfirmed,
                    child: Icon(
                      Icons.remove_red_eye, 
                      color: Colors.grey[200],
                    ),
                  ),
                  hintText: "Confirm your password",
                  hintStyle: TextStyle(
                    color: Colors.grey[200],
                  )
                ),
              ),
            ),
            MyButton(
              text: "Register", 
              onTap: register,
            )
          ],
        ),
      ),
    );
  }
}