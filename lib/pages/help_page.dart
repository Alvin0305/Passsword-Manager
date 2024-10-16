import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  HelpPage({super.key});

  List<String> heading = ["Add", "Edit", "Delete", "Delete Account"];
  List<String> content = ["To add a value use the + button", 
  "To edit a value double tap the value you want to edit", 
  "To delete a value long press the value you want to delete", 
  "This will delete your account and all the data in it", 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Color(0xFF2F4F4F),
        title: Text(
          "H E L P  P A G E", 
          style: TextStyle(
            color: Color(0xFFE0FFFF),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFE0FFFF),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: heading.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), 
                color: Color(0xFF2F4F4F),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    heading[index], 
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    content[index], 
                    style: TextStyle(
                      color: Color(0xFFE0FFFF),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}