import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/components/add_data_box.dart';
import 'package:password_app/components/delete_data_box.dart';
import 'package:password_app/components/details_box.dart';
import 'package:password_app/components/edit_data_box.dart';
import 'package:password_app/components/my_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _myBox = Hive.box('home_page_data');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  int count = 0;
  Color cardColor = Color(0xFF2F4F4F);

  String encrypted(String word) {
    String output = "";
    int n = word.length;
    for (int i = 0; i < n; i++) {
      int codedValue = (word.codeUnitAt(i) + n + i) % 127;
      String coded = String.fromCharCode(codedValue);
      output = output + coded;
    }
    return output;
  }

  String decrypted(String word) {
    String output = "";
    int n = word.length;
    for (int i = 0; i < n; i++) {
      int decodedValue = (word.codeUnitAt(i) - n - i) % 127;
      if (decodedValue < 0) {
        decodedValue += 127;
      }
      String decoded = String.fromCharCode(decodedValue);
      output = output + decoded;
    }
    return output;
  }

  void onSave() {
    print('count on save: $count');
    String title = _titleController.text;
    String type = _typeController.text;
    String value = _valueController.text;

    if (title.isNotEmpty && type.isNotEmpty && value.isNotEmpty) {
      setState(() {
        if (_myBox.containsKey(count)) {
        List data = _myBox.get(count);
        print(data);
        // List<List<String>> existingData = data[2];
        List<dynamic> existingData = data[2];
        existingData.add([type, value]);
        int c = data[1];
        _myBox.put(count, [title, c + 1, existingData]);
        } else {
          List data = [title, 1, [[type, value]]];
          _myBox.put(count, data);
        }
        count++;
        _myBox.put('count', count);
        _titleController.clear();
        _typeController.clear();
        _valueController.clear();
      });
    }
    

    Navigator.pop(context);
  }

  void onAdd() {
    String title = _titleController.text;
    String type = _typeController.text;
    String value = _valueController.text;
    if (title.isNotEmpty && type.isNotEmpty && value.isNotEmpty) {
      setState(() {
        if (_myBox.containsKey(count)) {
          List data = _myBox.get(count);
          // List<List<String>> existingData = data[2];
          List<dynamic> existingData = data[2];
          existingData.add([type, value]);
          int c = data[1];
          _myBox.put(count, [title, c + 1, existingData]);
        } else {
          List data = [title, 1, [[type, value]]];
          _myBox.put(count, data);
        }
        _typeController.clear();
        _valueController.clear();
      });
    }
  }

  void onCancel() {
    _titleController.clear();
    _typeController.clear();
    _valueController.clear();

    // print(encrypted('hello'));
    // print(decrypted(encrypted('hello')));

    // String p = 'hello';
    // String q = encrypted(p);
    // String r = decrypted(q);
    // print('$p $q $r');

    Navigator.pop(context);
  }

  void onDelete(int key) {
    print('key: $key');
    print('count: $count');
    setState(() {
      _myBox.delete(key);
      count--;
      _myBox.put('count', count);
    });
    for (int i = 0; i < count + 1; i++) {
      if (i > key) {
        var data = _myBox.get(i);
        _myBox.delete(i);
        _myBox.put(i-1, data);
      }
    }
    print(_myBox.get(key));
    print(_myBox.get(0));
    print(_myBox.get(1));
    print('count: $count');
    Navigator.pop(context);
  }

  void onEdit(int index) {
    String newTitle = _titleController.text;
    if (newTitle.isNotEmpty) {
      setState(() {
        List data = _myBox.get(index);
        data[0] = newTitle;
        _myBox.put(index, data);
        _titleController.clear();
      });
    }
    Navigator.pop(context);
  }

  void showEditDialogBox(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return EditDataBox(
          titleController: _titleController, 
          onEdit: () => onEdit(index), 
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
        return AddDataBox(
          titleController: _titleController, 
          typeController: _typeController, 
          valueController: _valueController, 
          onSave: onSave, 
          onAdd: onAdd, 
          onCancel: onCancel
        );
      }
    );
  }

  void showDetailsBox(int value) {
    showDialog(
      context: context, 
      builder: (context) {
        return DetailsBox(
          value: value, 
          myBox: _myBox,
        );
      }
    );
  }

  Future<void> deleteData() async {
    await _myBox.clear();
    if (_myBox.isEmpty) {
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
      count = _myBox.get('count', defaultValue: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 0, 
            mainAxisSpacing: 0, 
            childAspectRatio: 1,
          ), 
          itemCount: count,
          itemBuilder: (context, index) {
            var data = _myBox.get(index);
            if (data == null) {
              return Container();
            }
            return GestureDetector(
              onTap: () => showDetailsBox(index),
              onLongPress: () => showDeleteDialogBox(context, index),
              onDoubleTap: () => showEditDialogBox(context, index),
              child: GestureDetector(
                child: Card(
                  color: Color(0xFF2F4F4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              data[0], 
                              style: TextStyle(
                                color: Color(0xFFE0FFFF),
                                fontSize: 24,
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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