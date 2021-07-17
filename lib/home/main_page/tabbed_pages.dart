import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/home/home_page/view/home_page.dart';
import 'package:trivia_expert_app/home/main_page/cubit/main_page_cubit.dart';

import '../shop_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  State<StatefulWidget> createState() {
    return _TabbedState();
  }
}

class _TabbedState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    ShopPage(),
    Text('Experiment Three'),
    Text('Last Experiment')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(title: const Text('Login')),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.lightBlue,
              activeIcon: Text('womp'),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlue,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
