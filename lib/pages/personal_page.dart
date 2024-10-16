import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/components/add_data_box.dart';
import 'package:password_app/components/delete_data_box.dart';
import 'package:password_app/components/details_box.dart';
import 'package:password_app/components/edit_data_box.dart';
import 'package:password_app/components/my_button.dart';
import 'package:password_app/components/my_text.dart';
import 'package:password_app/components/my_text_box.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {

  var _personalBox = Hive.box('personal_page_data');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  int count = 0;

  void onSave() {
    print('count on save: $count');
    String title = _titleController.text;
    String value = _valueController.text;
    if (title.isNotEmpty && value.isNotEmpty) {
      setState(() {
        if (_personalBox.containsKey(count)) {
          List<dynamic> data = _personalBox.get(count);
          print(data);
          data.add([title, value]);
          _personalBox.put(count, data);
        } else {
          _personalBox.put(count, [title, value]);
        }
        count++;
        _personalBox.put('count', count);
        _titleController.clear();
        _valueController.clear();
      });
    }
    Navigator.pop(context);
  }

  // void onAdd() {
  //   String title = _titleController.text;
  //   String type = _typeController.text;
  //   String value = _valueController.text;
  //   if (title.isNotEmpty && type.isNotEmpty && value.isNotEmpty) {
  //     setState(() {
  //       if (_personalBox.containsKey(count)) {
  //         List data = _personalBox.get(count);
  //         List<dynamic> existingData = data[2];
  //         existingData.add([type, value]);
  //         int c = data[1];
  //         _personalBox.put(count, [title, c + 1, existingData]);
  //       } else {
  //         List data = [title, 1, [[type, value]]];
  //         _personalBox.put(count, data);
  //       }
  //       _typeController.clear();
  //       _valueController.clear();
  //     });
  //   }
  // }

  void onCancel() {
    _titleController.clear();
    _valueController.clear();
    Navigator.pop(context);
  }

  void onDelete(int key) {
    print('key: $key');
    print('count: $count');
    setState(() {
      _personalBox.delete(key);
      count--;
      _personalBox.put('count', count);
    });
    for (int i = 0; i < count + 1; i++) {
      if (i > key) {
        var data = _personalBox.get(i);
        _personalBox.delete(i);
        _personalBox.put(i-1, data);
      }
    }
    print(_personalBox.get(key));
    print(_personalBox.get(0));
    print(_personalBox.get(1));
    print('count: $count');
    Navigator.pop(context);
  }

  void onEditTitle(int index) {
    String newTitle = _titleController.text;
    if (newTitle.isNotEmpty) {
      setState(() {
        List data = _personalBox.get(index);
        data[0] = newTitle;
        _personalBox.put(index, data);
        _titleController.clear();
      });
    }
    Navigator.pop(context);
  }

  void showEditTitleDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return EditDataBox(
          titleController: _titleController, 
          onEdit: () => onEditTitle(index), 
          onCancel: onCancel
        );
      }
    );
  }

  void onEditValue(int index) {
    String newValue = _valueController.text;
    if (newValue.isNotEmpty) {
      setState(() {
        List data = _personalBox.get(index);
        data[1] = newValue;
        _personalBox.put(index, data);
        _valueController.clear();
      });
    }
    Navigator.pop(context);
  }

  void showEditValueDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return EditDataBox(
          titleController: _valueController, 
          onEdit: () => onEditValue(index), 
          onCancel: onCancel
        );
      }
    );
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

  void showAddDialogBox(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Text(
            "Add new Data", 
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
                  hintText: "Title...", 
                  controller: _titleController, 
                  obscureText: false,
                ),
                MyTextBox(
                  hintText: "Value...", 
                  controller: _valueController, 
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

  Future<void> deleteData() async {
    await _personalBox.clear();
    if (_personalBox.isEmpty) {
      print('emptied');
    } else {
      print('not emptied');
    }
  }

  @override
  void initState() {
    super.initState();
    // deleteData();
    setState(() {
      count = _personalBox.get('count', defaultValue: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            var data = _personalBox.get(index);
            if (data == null) {
              return Container();
            }
            return GestureDetector(
              onLongPress: () => showDeleteDialogBox(context, index),
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xFF2F4F4F),
                  ),
                  child: ListTile(
                    
                    leading: GestureDetector(
                      onDoubleTap: () => showEditTitleDialogBox(context, index),
                      child: Text(
                        data[0], 
                        style: TextStyle(
                          color: Color(0xFFE0FFFF), 
                          fontSize: 16,
                        ),
                      ),
                    ),
                    trailing: GestureDetector(
                      onDoubleTap: () => showEditValueDialogBox(context, index),
                      child: Text(
                        data[1], 
                        style: TextStyle(
                          color: Color(0xFFE0FFFF), 
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )

            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2F4F4F),
        onPressed: () => showAddDialogBox(context),
        child: Icon(
          Icons.add, 
          size: 32,
          color: Color(0xFFE0FFFF),
        ),
      ),
    );
  }
}