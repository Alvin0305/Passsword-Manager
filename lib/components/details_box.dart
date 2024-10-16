import 'package:flutter/material.dart';
import 'package:password_app/components/delete_data_box.dart';
import 'package:password_app/components/edit_data_box.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text_box.dart';

class DetailsBox extends StatefulWidget {

  final int value;
  final myBox;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  DetailsBox({
    super.key,
    required this.value,
    required this.myBox,
  });

  @override
  State<DetailsBox> createState() => _DetailsBoxState();
}

class _DetailsBoxState extends State<DetailsBox> {
 
  void onDelete(int index) {
    List data = widget.myBox.get(widget.value);
    data[2].removeAt(index);
    data[1]--;
    setState(() {
      widget.myBox.put(widget.value, data);
    });
    Navigator.pop(context);
  }

  void onCancel() {
    widget.typeController.clear();
    widget.valueController.clear();
    Navigator.pop(context);
  }

  void showDeleteDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return DeleteDataBox(
          onDelete: () => onDelete(index), 
          onCancel: onCancel
        );
      }
    );
  }

  void onEdit(int index, int k) {
    List data = widget.myBox.get(widget.value);
    String newType = widget.typeController.text;
    data[2][index][k] = newType;
    setState(() {
      widget.myBox.put(widget.value, data);
    });
    onCancel();
  }

  void showEditTypeDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return EditDataBox(
          titleController: widget.typeController, 
          onEdit: () => onEdit(index, 0), 
          onCancel: onCancel
        );
      }
    );
  }

  void showEditValueDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return EditDataBox(
          titleController: widget.typeController, 
          onEdit: () => onEdit(index, 1), 
          onCancel: onCancel
        );
      }
    );
  }

  void onSave() {
    String type = widget.typeController.text;
    String value = widget.valueController.text;
    List data = widget.myBox.get(widget.value);
    data[2].add([type, value]);
    data[1]++;
    setState(() {
      if (type.isNotEmpty && value.isNotEmpty) {
        widget.myBox.put(widget.value, data);
      }
    });
    onCancel();
  }

  void showAddDialogBox(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Text(
            'Add new value', 
            style: TextStyle(
              color: Colors.grey[200],
            ),
          ),
          content: Container(
            height: 200,
            width: 220,
            child: Column(
              children: [
                MyTextBox(
                  hintText: "New Type...", 
                  controller: widget.typeController, 
                  obscureText: false,
                ),
                MyTextBox(
                  hintText: "New Value...", 
                  controller: widget.valueController, 
                  obscureText: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: "Save", 
                      onTap: onSave,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      backgroundColor: Colors.grey[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 220,
              child: ListView.builder(
                itemCount: widget.myBox.get(widget.value)[1],
                itemBuilder: (context, index) {
                  List data = widget.myBox.get(widget.value);
                  return GestureDetector(
                    onLongPress: () => showDeleteDialogBox(context, index),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: GestureDetector(
                          onDoubleTap: () => showEditTypeDialogBox(context, index),
                          child: Text(
                            data[2][index][0], 
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: (data[2][index][0].length + data[2][index][1].length > 25)? 15: 20,
                            ),
                          ),
                        ),
                        trailing: GestureDetector(
                          onDoubleTap: () => showEditValueDialogBox(context, index),
                          child: Text(
                            data[2][index][1], 
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: (data[2][index][0].length + data[2][index][1].length > 25)? 15: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => showAddDialogBox(context),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100, 10),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                child: Icon(
                  Icons.add, 
                  color: Colors.grey[600],
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}