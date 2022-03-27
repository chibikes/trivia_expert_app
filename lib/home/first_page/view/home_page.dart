import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_expert_app/home/first_page/profile_page/view/profile_page.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/power_up_container.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

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
  late AnimationController _circularProgressController = AnimationController(lowerBound: 0.0, upperBound: GamingStats.recentStats[accuracyStat]?.toDouble() ?? 0.0, vsync: this, duration: Duration(seconds: 3),);
  @override
  void initState() {
    _circularProgressController.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  Future<void> startAnimation() async{
    await Future.delayed(Duration(seconds: 5)).then((value) => _circularProgressController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
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
          var recentStats = GamingStats.recentStats;
          startAnimation();
          return BlocListener<FirstPageCubit, FirstPageState>(
            listener: (context, state) {},
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text('TRIVIA EXPERT', style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
                SizedBox(height: 16.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: BlocBuilder<ShopCubit, ShopState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: PowerUpContainer(
                                powerUpQty: state.blueCrystals.toString(), powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlueCrystal(height: 20, width: 20,),
                                ],
                              ), height: 0.05 * MediaQuery.of(context).size.height, width: 0.30 * MediaQuery.of(context).size.width,),
                            ),
                            Expanded(
                              child: PowerUpContainer(
                                powerUpQty: state.redCrystals.toString(),powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RedLifeCrystal(height: 20, width: 20,),
                                ],
                              ), height: 0.05 * MediaQuery.of(context).size.height, width: 0.30 * MediaQuery.of(context).size.width,),
                            ),
                            Expanded(
                              child: PowerUpContainer(
                                powerUpQty: state.rightAnswers.toString(),powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RightAnswer(height: 20, width: 20,),
                                ],
                              ), height: 0.05 * MediaQuery.of(context).size.height, width: 0.30 * MediaQuery.of(context).size.width,),
                            ),
                          ],
                        );
                      }
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 42.0,
                          backgroundImage: NetworkImage(context
                              .read<MainBloc>()
                              .state
                              .user!
                              .photo!),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(children: [SizedBox(width: 0.70 * MediaQuery.of(context).size.width,),Text('Edit', style: TextStyle(color: Colors.white),), Icon(Icons.edit, color: Colors.white,)],),
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xffffd700)),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
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
                        SizedBox(width: 10.0,),
                        Text(context.read<MainBloc>().user.name ?? context.read<MainBloc>().user.email ?? 'User Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Center(child: Text('HIGH SCORE ${GamingStats.recentStats[highScore]}', style: GoogleFonts.gothicA1(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),),
                SizedBox(height: 20.0,),
                Center(child: Text('LEVEL ${GamingStats.recentStats[gameLevel]}', style: GoogleFonts.gothicA1(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),),
                SizedBox(
                  height: 50.0,
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
                SizedBox(height: 30.0,),
              ],
            ),
          );
        case HomeStatus.waiting:
          return CircularProgressIndicator();
      }
    });
  }
}

