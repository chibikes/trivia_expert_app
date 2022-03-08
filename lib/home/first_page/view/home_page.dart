import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/game_page.dart';
import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_expert_app/home/first_page/profile_page/view/profile_page.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import 'package:repo_packages/src/models/gamestate.dart';

class Home extends StatefulWidget {
  Home();

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController? _bounceController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  void gameSess(String id) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      List sessionIDs = [];
      // if(state.gameStates.isEmpty) {
      // state.gameStates.forEach((element) {
      //   sessionIDs.add(element.sessionID);
      // });
      // }
      // final Stream<QuerySnapshot> _gameStates = FirebaseFirestore.instance
      //     .collection('gameStates')
      //     .where('sessionID', arrayContains: sessionIDs)
      //     .snapshots();

      switch (state.homeStatus) {
        case HomeStatus.failure_update:
          return Text('remove me later');
        case HomeStatus.updated:
          return Column(
            children: [
              Text(context.read<MainBloc>().state.user!.age ?? 'null'),
              ElevatedButton(
                onPressed: () {
                  context.read<FirstPageCubit>().goToPage(
                        context,
                        ProfilePage(
                          context: context,
                        ),
                      );
                },
                child: Text('Go to ->'),
              )
            ],
          );
        case HomeStatus.fetched:
          return BlocListener<FirstPageCubit, FirstPageState>(
            listener: (context, state) {},
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xffffd700)),
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      gradient:
                          LinearGradient(begin: Alignment(0.2, 0.0), colors: [
                        Color(0xff1e4b7a),
                        Color(0xff1e66ae),
                      ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(context
                                    .read<MainBloc>()
                                    .state
                                    .user!
                                    .photo!),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 20),
                                child: GestureDetector(
                                  // onTap: () =>
                                  //     context.read<FirstPageCubit>().goToPage(
                                  //           context,
                                  //           BlocProvider.value(
                                  //             value: BlocProvider.of<MainBloc>(
                                  //                 context),
                                  //             child: ProfilePage(
                                  //               context: context,
                                  //             ),
                                  //           ),
                                  //       GamePlayState(),
                                  //         ),
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 0.0, bottom: 40.0),
                        //   child: Text('Username',
                        //       style: TextStyle(
                        //           fontFamily: 'ShowCardGothic',
                        //           color: Colors.white,
                        //           fontSize: 20)),
                        // ),
                        CheckMark(
                          height: 30,
                          width: 30,
                          smallSize: true,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 0.05 * MediaQuery.of(context).size.width,
                        ),
                        BlueCrystal(
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 0.05 * MediaQuery.of(context).size.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: RedLifeCrystal(
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            '3',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 16.0,
                    // color: Colors.cyan,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('HIGH SCORE : 20',
                                style: TextStyle(
                                    fontFamily: 'ShowCardGothic',
                                    color: Colors.black,
                                    fontSize: 20)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Tasks',
                              style: GoogleFonts.aleo(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wine_bar_rounded,
                                  color: Colors.orange,
                                ),
                                Text('Win a participation trophy'),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wine_bar_rounded,
                                  color: Colors.orange,
                                ),
                                Text('Win in all category')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 0.70).animate(
                      CurvedAnimation(
                          parent: _bounceController!,
                          curve: Curves.bounceInOut)),
                  child: SizedBox(
                    height: 65,
                    width: 0.80 * MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: RoundRectBubbleButton(
                        text: 'Play',
                        onPressed: () =>
                            context.read<FirstPageCubit>().goToPage(
                                  context,
                                  SinglePlayerPage(),
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        case HomeStatus.waiting:
          return CircularProgressIndicator();
      }
    });
  }
}

// SizedBox(
// width: 5,
// ),
// BubbleButton(),
