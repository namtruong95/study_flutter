import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/src/components/authentication/authentication.dart';

class MenuConstant {
  static const String Logout = 'Logout';
}

class LayoutAppBar extends StatelessWidget {
  final String title;

  final List<MenuItem> menus = [
    MenuItem(
      id: MenuConstant.Logout,
      title: 'Logout',
      icon: Icons.lock_open,
    ),
  ];

  LayoutAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return AppBar(
      elevation: 0.0,
      title: Center(
        child: Text(title),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            print('notification');
          },
        ),
        PopupMenuButton(
          onSelected: (MenuItem menuItem) {
            switch (menuItem.id) {
              case MenuConstant.Logout:
                authenticationBloc.dispatch(LoggedOut());
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return menus.map((MenuItem menuItem) {
              return PopupMenuItem<MenuItem>(
                value: menuItem,
                child: new Row(
                  children: <Widget>[
                    Icon(Icons.lock_open),
                    Text(menuItem.title)
                  ],
                ),
              );
            }).toList();
          },
        )
      ],
    );
  }
}

class MenuItem {
  final String id;
  final String title;
  final IconData icon;

  MenuItem({
    @required this.id,
    @required this.title,
    this.icon,
  });
}
