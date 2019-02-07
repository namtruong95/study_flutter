import 'package:flutter/material.dart';

class LayoutBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  const LayoutBottomNavBar(
      {@required this.onTabSelected, @required this.selectedIndex});

  void _updateIndex(int index) {
    onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _updateIndex,
      currentIndex: selectedIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Tab 1'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Tab 2'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Tab 3'),
        )
      ],
    );
  }
}
