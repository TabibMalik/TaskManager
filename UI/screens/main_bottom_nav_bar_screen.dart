import 'package:flutter/material.dart';
import 'package:untitled/UI/screens/cancelled_task_screen.dart';
import 'package:untitled/UI/screens/completed_task_screen.dart';
import 'package:untitled/UI/screens/in_progress_task_screen.dart';
import 'package:untitled/UI/screens/new_task_screen.dart';

import '../widgets/tm_app_bar.dart';

class mainBottomNavBarScreen extends StatefulWidget {
  const mainBottomNavBarScreen({super.key});

  @override
  State<mainBottomNavBarScreen> createState() => _mainBottomNavBarScreenState();
}

class _mainBottomNavBarScreenState extends State<mainBottomNavBarScreen> {

  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index){
          _selectedIndex = index;
          setState(() {

          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.new_label),
              label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.close),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_filled_outlined),
            label: 'In Progress',
          ),
        ],
      ),
    );
  }
}


