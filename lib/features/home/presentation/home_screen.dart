import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/utils/custom_floating_action_button.dart';
import 'package:to_do/features/home/widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final String path;
  final StatefulNavigationShell navigationShell;
  const HomeScreen({
    super.key,
    required this.navigationShell,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(path),
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          navigationShell.goBranch(
            value,
            initialLocation:
                value == navigationShell.currentIndex,
          );
        },
      ),
      floatingActionButton:
          (path == '/tasks/add' ||
              path == '/history' ||
              path == '/profile')
          ? null
          : CustomFloatingActionButton(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
    );
  }

  Widget getTitle(String title) {
    String finalTitle;
    if (title == '/tasks') {
      finalTitle = 'Tasks';
    } else if (title == '/history') {
      finalTitle = 'History';
    } else if (title == '/profile') {
      finalTitle = 'Profile';
    } else {
      finalTitle = '';
    }
    return Text(
      finalTitle,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
  }
}
