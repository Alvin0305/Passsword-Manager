import 'package:flutter/material.dart';
import 'package:password_app/components/my_button.dart';

class DeleteDataBox extends StatelessWidget {

  Function()? onDelete;
  Function()? onCancel;

  DeleteDataBox({
    super.key, 
    required this.onDelete, 
    required this.onCancel, 
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[700],
      title: Text(
        "Do you want to delete", 
        style: TextStyle(
          color: Colors.grey[200],
        ),
      ),
      content: Container(
        height: 60,
        width: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Yes", 
                  onTap: onDelete,
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
    );;
  }
}