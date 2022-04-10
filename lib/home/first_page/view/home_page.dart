import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

import '../../../widgets/trophy_cup_layer.dart';

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
                                  BlueCrystal(height: 12, width: 12,),
                                ],
                              ), height: 0.04 * MediaQuery.of(context).size.height, width: 0.25 * MediaQuery.of(context).size.width,),
                            ),
                            Expanded(
                              child: PowerUpContainer(
                                powerUpQty: state.redCrystals.toString(),powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RedLifeCrystal(height: 12, width: 12,),
                                ],
                              ), height: 0.04 * MediaQuery.of(context).size.height, width: 0.25 * MediaQuery.of(context).size.width,),
                            ),
                            Expanded(
                              child: PowerUpContainer(
                                powerUpQty: state.rightAnswers.toString(),powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RightAnswer(height: 12, width: 12,),
                                ],
                              ), height: 0.04 * MediaQuery.of(context).size.height, width: 0.25 * MediaQuery.of(context).size.width,),
                            ),
                          ],
                        );
                      }
                  ),
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black38)],
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 42.0,
                                backgroundImage: CachedNetworkImageProvider(context
                                    .read<MainBloc>()
                                    .state
                                    .user!
                                    .photo!),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(top: 70.0, left: 70.0,child: Icon(Icons.camera_alt, color: Colors.cyan,)),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Color(0xffffd700), width: 2.0)),
                    // borderRadius: BorderRadius.circular(0.0),
                    gradient:
                        LinearGradient(begin: Alignment(0.2, 0.0), colors: [
                      Color(0xff1e4b7a),
                      Color(0xff1e66ae),
                    ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Badge(badgeContent: Icon(Icons.edit, color: Colors.white, size: 10,),child: Text(context.read<MainBloc>().user.name ?? context.read<MainBloc>().user.email ?? 'User Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xff8b5a2b)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Stack(
                                children: [
                                  Icon(FontAwesomeIcons.trophy, color: Colors.orange, size: 30,),
                                  Positioned(
                                    top: 3.0,
                                    left: 8.0,
                                    child: CustomPaint(
                                      painter: TrophyLayerPainter(),
                                      size: Size(20, 15),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.0,
                                    left: 20.0,
                                    child: Container(
                                      height: 3,
                                      width: 3,
                                      decoration: BoxDecoration(
                                          color: Colors.white24,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text('${GamingStats.recentStats[highScore]}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),),
                            ],
                            ),
                            Divider(thickness: 2.0, color: Colors.white,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Icon(FontAwesomeIcons.trophy, color: Colors.blue, size: 30,),
                                    Positioned(
                                      top: 3.0,
                                      left: 8.0,
                                      child: CustomPaint(
                                        painter: TrophyLayerPainter(),
                                        size: Size(20, 15),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8.0,
                                      left: 20.0,
                                      child: Container(
                                        height: 3,
                                        width: 3,
                                        decoration: BoxDecoration(
                                            color: Colors.white24,
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('${GamingStats.recentStats[gameLevel]}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.0,
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

