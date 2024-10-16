import 'package:flutter/material.dart';
import 'package:password_app/pages/home_page.dart';
import 'package:password_app/pages/login_page.dart';
import 'package:password_app/pages/work_page.dart';

class GeneralPage extends StatelessWidget {

  int pageNumber;
  

  GeneralPage({
    super.key, 
    required this.pageNumber,
  });

  @override
  Widget build(BuildContext context) {
    if (pageNumber == 1) {
      return HomePage();
    } else if (pageNumber == 2) {
      return WorkPage();
    } else {
      return LoginPage(); // no use
    }
  }
}