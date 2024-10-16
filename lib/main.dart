import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/pages/first_page.dart';
import 'package:password_app/pages/general_page.dart';
import 'package:password_app/pages/help_page.dart';
import 'package:password_app/pages/home_page.dart';
import 'package:password_app/pages/login_or_reg_page.dart';
import 'package:password_app/pages/login_page.dart';
import 'package:password_app/pages/personal_page.dart';
import 'package:password_app/pages/register_page.dart';
import 'package:password_app/pages/settings_page.dart';
import 'package:password_app/pages/work_page.dart';

void main() async {

  await Hive.initFlutter();

  var home_page_data = await Hive.openBox('home_page_data');
  var work_page_data = await Hive.openBox('work_page_data');
  var personal_page_data = await Hive.openBox('personal_page_data');
  var password_data = await Hive.openBox('password_data');
  var data = await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(), 
        '/settings': (context) => SettingsPage(), 
        '/work': (context) => WorkPage(), 
        '/personal': (context) => PersonalPage(),
        '/login': (context) => LoginPage(),
        '/first': (context) => FirstPage(),
        '/register': (context) => RegisterPage(),
        '/help': (context) => HelpPage(),
      },
      // home: LoginPage(),
      home: LoginOrRegPage(),
    );
  }
}

// password: alvin

// class Settings {
// }