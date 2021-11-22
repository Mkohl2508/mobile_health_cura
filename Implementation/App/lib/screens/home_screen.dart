import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/calendar_view_screen.dart';
import 'package:cura/screens/notification_screen.dart';
import 'package:cura/screens/patient_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    PatienListScreen(),
    CalendarViewScreen(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              backgroundColor: AppColors.cura_brown,
              onPressed: () {},
            )
          : null,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage("assets/cura_header.png"),
              ),
            ),
          ),
          tabs[_currentIndex],
        ],
      ),
      backgroundColor: AppColors.cura_background,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.cura_orange,
        selectedItemColor: Colors.white,
        iconSize: 20,
        selectedIconTheme: IconThemeData(size: 30),
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Patient list",
            backgroundColor: Colors.white,
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            label: "Calendar",
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: "Notification",
            activeIcon: Icon(Icons.notifications_active),
            icon: Icon(Icons.notifications),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
