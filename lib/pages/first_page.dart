import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_app/pages/home_page.dart';
import 'package:password_app/pages/personal_page.dart';
import 'package:password_app/pages/settings_page.dart';
import 'package:password_app/pages/work_page.dart';

class FirstPage extends StatefulWidget {

  FirstPage({
    super.key, 
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  int _currentIndex = 1;

  final List<Widget> _pages = [
    
    PersonalPage(), 
    HomePage(), 
    WorkPage(),
    SettingsPage(),
  ];

  final PageController _pageController = PageController(initialPage: 1);

  final dataBox = Hive.box('data');

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.jumpToPage(index);
  }

  final List<String> titleList = [
    
    "P E R S O N A L  P A G E", 
    "H O M E  P A G E", 
    "W O R K  P A G E",
    "S E T T I N G S  P A G E" 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 10.0,
        title: Text(
          titleList[_currentIndex], 
          style: TextStyle(
            color: Color(0xFFE0FFFF),
          ),
        ),
        backgroundColor: Color(0xFF2F4F4F),
        iconTheme: IconThemeData(
          color: Color(0xFFE0FFFF),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF2F4F4F),
        selectedItemColor: Color(0xFFE0FFFF),
        showUnselectedLabels: false,
        // unselectedItemColor: Colors.grey[300],
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person, 
              color: Color(0xFFE0FFFF),
            ),
            label: "Personal",
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home, 
              color: Color(0xFFE0FFFF),
            ),
            label: "Home",
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work, 
              color: Color(0xFFE0FFFF),
            ),
            label: "Work",
          ), 
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings, 
              color: Color(0xFFE0FFFF),
            ),
            label: "Settings",
          ), 
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),

    );
  }
}