import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int)? onTap;
  final int currentIndex;
  const CustomBottomNavBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.grey[900],
      selectedFontSize: 16,
      unselectedFontSize: 13,
      elevation: 1.0,
      backgroundColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),

      items: [
        BottomNavigationBarItem(
          label: 'tasks',
          tooltip: 'tasks',
          icon: Icon(Icons.task_outlined),
          activeIcon: Icon(Icons.task),
        ),
        BottomNavigationBarItem(
          label: 'history',
          tooltip: 'history',
          icon: Icon(Icons.history_toggle_off),
          activeIcon: Icon(Icons.history_rounded),
        ),
        BottomNavigationBarItem(
          label: 'settings',
          tooltip: 'settings',
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
