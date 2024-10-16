import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmpwController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final dataBox = Hive.box('data');

  void showChangePWDialogBox() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Text(
            "Change Password", 
            style: TextStyle(
              color: Colors.grey[200],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextBox(
                hintText: "Enter new Password", 
                controller: pwController, 
                obscureText: false,
              ), 
              MyTextBox(
                hintText: "Confirm new Password", 
                controller: confirmpwController, 
                obscureText: false,
              ), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyButton(
                    text: "Save", 
                    onTap: () {
                      if (pwController.text.isNotEmpty && pwController.text == confirmpwController.text) {
                        dataBox.put('password', pwController.text);
                      }
                      pwController.clear();
                      confirmpwController.clear();
                      Navigator.pop(context);
                    },
                  ),
                  MyButton(
                    text: "Cancel", 
                    onTap: () {
                      pwController.clear();
                      confirmpwController.clear();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  void showChangeNameDialogBox() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Text(
            "Change Name", 
            style: TextStyle(
              color: Colors.grey[200],
            ),
          ),
          content: Container(
            height: 130,
            child: Column(
              children: [
                MyTextBox(
                  hintText: "Enter new Name", 
                  controller: nameController, 
                  obscureText: false,
                ), 
                Row(
                  children: [
                    MyButton(
                      text: "Save", 
                      onTap: () {
                        if (nameController.text.isNotEmpty) {
                          dataBox.put('name', nameController.text);
                        }
                        nameController.clear();
                        Navigator.pop(context);
                      },
                    ),
                    MyButton(
                      text: "Cancel", 
                      onTap: () {
                        nameController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void showAreYouSureBox() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Text(
            "Are you sure", 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[200],
            ),
          ),
          content: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Yes", 
                  onTap: () {
                    var home_page_data = Hive.box('home_page_data');
                    var work_page_data = Hive.box('work_page_data');
                    var personal_page_data = Hive.box('personal_page_data');
                    var password_data = Hive.box('password_data');
                    // var data = Hive.box('data');
                    home_page_data.clear();
                    work_page_data.clear();
                    personal_page_data.clear();
                    password_data.clear();
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      '/register', 
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                MyButton(
                  text: "Cancel", 
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: showChangePWDialogBox,
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), 
                  color: Color(0xFF2F4F4F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Password', 
                      style: TextStyle(
                        color: Color(0xFFE0FFFF),
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right, 
                      color: Color(0xFFE0FFFF),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: showChangeNameDialogBox,
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), 
                  color: Color(0xFF2F4F4F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Name', 
                      style: TextStyle(
                        color: Color(0xFFE0FFFF),
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right, 
                      color: Color(0xFFE0FFFF),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: showAreYouSureBox,
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), 
                  color: Color(0xFF2F4F4F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delete Account', 
                      style: TextStyle(
                        color: Color(0xFFE0FFFF),
                        fontSize: 15,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right, 
                      color: Color(0xFFE0FFFF),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2F4F4F),
        onPressed: () {
          Navigator.pushNamed(context, '/help');
        }, 
        child: Icon(
          Icons.question_mark, 
          color: Color(0xFFE0FFFF),
        ),
      ),
    );
  }
}