import 'package:flutter/material.dart';

import 'package:study_flutter/src/components/tab_layout/tab_layout.dart';
import 'package:study_flutter/src/components/tabs/tabs.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _tabs = [
    Tab1(),
    Tab2(),
    Tab3(),
  ];

  final List<String> _titlePages = [
    'Tab 1',
    'Tab 2',
    'Tab 3',
  ];

  void _tabSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: LayoutAppBar(
          title: _titlePages[_selectedIndex],
        ),
      ),
      body: Container(
        child: Center(
          child: _tabs[_selectedIndex],
        ),
      ),
      bottomNavigationBar: LayoutBottomNavBar(
        onTabSelected: _tabSelect,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
