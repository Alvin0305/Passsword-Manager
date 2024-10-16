import 'package:flutter/material.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';

class EditDataBox extends StatelessWidget {

  final TextEditingController titleController;
  Function()? onEdit;
  Function()? onCancel;

  EditDataBox({
    super.key, 
    required this.titleController,
    required this.onEdit, 
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[700],
      title: Text(
        "Edit Title", 
        style: TextStyle(
          color: Colors.grey[200],
        ),
      ),
      content: Container(
        height: 130,
        width: 220,
        child: Column(
          children: [
            MyTextBox(
              hintText: "New Title...", 
              controller: titleController, 
              obscureText: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyButton(
                  text: "Edit", 
                  onTap: onEdit,
                ), 
                MyButton(
                  text: "Cancel", 
                  onTap: onCancel,
                ), 
              ],
            )
          ],
        ),
      ),
    );
  }
}