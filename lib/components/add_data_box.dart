import 'package:flutter/material.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';

class AddDataBox extends StatefulWidget {

  final TextEditingController titleController;
  final TextEditingController typeController;  
  final TextEditingController valueController;
  Function()? onSave;
  Function()? onAdd;
  Function()? onCancel;

  AddDataBox({
    super.key, 
    required this.titleController, 
    required this.typeController, 
    required this.valueController,
    required this.onSave,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  State<AddDataBox> createState() => _AddDataBoxState();
}

class _AddDataBoxState extends State<AddDataBox> {
  bool pwboxchecked = false;

  bool usernameBoxchecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[700],
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
      title: Text(
        "Add new Data", 
        style: TextStyle(
          color: Colors.grey[200],
        ),
      ),
      content: Container(
        height: 320,
        width: 220,
        child: Column(
          children: [
            MyTextBox(
              hintText: "Title...", 
              controller: widget.titleController, 
              obscureText: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: pwboxchecked, 
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == false) {
                        widget.typeController.text = "";  
                      } else {
                        widget.typeController.text = "Password";
                      }
                      pwboxchecked = !pwboxchecked;
                      usernameBoxchecked = false;
                    });
                  },
                ),
                Text(
                  "Password", 
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
                Checkbox(
                  value: usernameBoxchecked, 
                  onChanged: (bool?value) {
                    setState(() {
                      if (value == false) {
                        widget.typeController.text = "";  
                      } else {
                        widget.typeController.text = "Username";
                      }
                      usernameBoxchecked = !usernameBoxchecked;
                      pwboxchecked = false;
                    });
                  },
                ),
                Text(
                  "Username", 
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
            MyTextBox(
              hintText: "Type...", 
              controller: widget.typeController, 
              obscureText: false,
            ),
            MyTextBox(
              hintText: "Value...", 
              controller: widget.valueController, 
              obscureText: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyButton(
                  text: "Save", 
                  onTap: widget.onSave,
                ), 
                MyButton(
                  text: "Add", 
                  onTap: widget.onAdd,
                ), 
                MyButton(
                  text: "Cancel", 
                  onTap: widget.onCancel,
                ), 
              ],
            )
          ],
        ),
      ),
    );
  }
}