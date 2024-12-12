import 'package:flutter/material.dart';
import 'package:wemos_app/screen/homeScreen1.dart';
import 'package:wemos_app/screen/monitorScreen1.dart';
import 'package:wemos_app/screen/table1.dart';

// Main wrapper widget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to display
  final List<Widget> _screens = [
    HomeScreen1(),
    ChartPage1(),
    DataTableScreen1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_outlined),
              activeIcon: Icon(Icons.insert_chart),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_rows_outlined),
              activeIcon: Icon(Icons.table_rows),
              label: 'Datatable',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xff50C878), // Primary green color
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
