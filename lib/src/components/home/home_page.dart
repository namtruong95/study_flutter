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
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 1;

  List<Widget> _tabs;

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
  void initState() {
    _tabs = [
      Tab1(
        key: keyOne,
        bucket: bucket,
      ),
      Tab2(),
      Tab3()
    ];

    super.initState();
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
      body: PageStorage(
        child: Container(
          child: Center(
            child: _tabs[_selectedIndex],
          ),
        ),
        bucket: bucket,
      ),
      bottomNavigationBar: LayoutBottomNavBar(
        onTabSelected: _tabSelect,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
