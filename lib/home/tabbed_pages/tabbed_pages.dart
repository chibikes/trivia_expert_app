import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:trivia_expert_app/home/first_page/view/home_page.dart';
import 'package:trivia_expert_app/widgets/other_widgets/mainpage_container.dart';
import '../../settings_page.dart';
import '../leaderboardpage.dart';
import '../shop_page.dart';

class HomePage extends StatefulWidget {
  // final FirebaseUserRepository? userRepository;

  const HomePage({
    Key? key,
  }) : super(key: key);
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
    LeaderBoardPage(),
    SettingsPage(),
    // MultiPlayer(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MainPageContainer(
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => FirstPageCubit(
                    FirstPageState(),
                  ),
                ),
              ],

              // create: (_) =>
              //     MainPageBloc(MainPageState(homeStatus: HomeStatus.idle)),
              child: _widgetOptions.elementAt(_selectedIndex)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
              backgroundColor: Colors.lightBlue,
              activeIcon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.trophy), label: 'LeaderBoard'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlue,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
