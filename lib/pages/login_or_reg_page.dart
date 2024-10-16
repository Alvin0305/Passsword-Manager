import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/pages/login_page.dart';
import 'package:password_app/pages/register_page.dart';

class LoginOrRegPage extends StatelessWidget {
  LoginOrRegPage({super.key});

  final dataBox = Hive.box('data');

  @override
  Widget build(BuildContext context) {
    if (dataBox.get('password') != null && dataBox.get('password').isNotEmpty) {
      print('here: ${dataBox.get('password')}');
      return LoginPage();
    } else {
      print('here: no');
      return RegisterPage();
    }
  }
}