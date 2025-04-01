import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:password_manager_app/model/password_data.dart';
import 'package:password_manager_app/screens/analysis_screen.dart';
import 'package:password_manager_app/screens/home_screen.dart';
import 'package:password_manager_app/screens/search_screen.dart';
import 'package:password_manager_app/screens/settings/profile_screen.dart';
import 'package:password_manager_app/screens/settings/settings_screen.dart';

import 'add_password_screen.dart';

class MainPage extends StatefulWidget {
  int index;
  MainPage({super.key, required this.index});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const AnalysisScreen(),
    const SearchScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateToProfile() {
    setState(() {
      _selectedIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: Colors.grey[100],
          currentIndex:
              _selectedIndex < 4 ? _selectedIndex : 3, // Prevent crash
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.black87),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'Analysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
