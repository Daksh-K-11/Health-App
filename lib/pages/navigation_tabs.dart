import 'package:flutter/material.dart';
import 'package:shriwin/widgets/chatbot.dart';
import 'package:shriwin/widgets/check_up.dart';
import 'package:shriwin/widgets/home.dart';
import 'package:shriwin/widgets/profile.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  String title = 'Home';
  int _selectedIndex = 0;
  Widget activepage = const HomePage();

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0){
      activepage = const HomePage();
      title = 'Home';
    }
    else if (_selectedIndex == 1) {
      activepage = const CheckUp();
      title = 'Check Up';
    }
    else if (_selectedIndex == 2) {
      activepage = const Chatbot();
      title = 'Ask AI';
    }
    else {
      activepage = const ProfilePage();
      title = 'Profile';
    }
    
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue[100],
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        selectedFontSize: 15,
        unselectedFontSize: 11,
        selectedItemColor: Colors.white,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'CheckUp'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'ChatBot'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}
