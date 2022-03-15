import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:trivia_expert_app/home/first_page/view/home_page.dart';
import 'package:trivia_expert_app/home/multi_player.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/widgets/game_widgets/check_mark_widget.dart';
import 'package:trivia_expert_app/widgets/game_widgets/cyrstal.dart';
import 'package:trivia_expert_app/widgets/other_widgets/first_aid_box.dart';
import 'package:trivia_expert_app/widgets/other_widgets/mainpage_container.dart';
import '../leaderboardpage.dart';
import '../shop_page.dart';

class HomePage extends StatefulWidget {
  final UserRepository? userRepository;

  const HomePage({Key? key, this.userRepository = const UserRepository()}) : super(key: key);
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
    MultiPlayer(),
    Text('Last Experiment'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MainPageContainer(
          child: RepositoryProvider.value(
            value: widget.userRepository,
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
        ),
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
