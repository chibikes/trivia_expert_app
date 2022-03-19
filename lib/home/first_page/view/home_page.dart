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
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 0.0, bottom: 40.0),
                        //   child: Text('Username',
                        //       style: TextStyle(
                        //           fontFamily: 'ShowCardGothic',
                        //           color: Colors.white,
                        //           fontSize: 20)),
                        // ),
                        SizedBox(width: 50.0,),
                        RightAnswer(
                          height: 30,
                          width: 30,
                          smallSize: true,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 10.0),
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
                              fontSize: 10.0),
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
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
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
                SizedBox(height: 16.0),
                Center(child: Text('HIGH SCORE', style: GoogleFonts.gothicA1(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),),),
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
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Recent Stats', style: GoogleFonts.gothicA1(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('Accuracy'),
                              SizedBox(height: 12.0,),
                              SizedBox(
                                width: 0.20 * MediaQuery.of(context).size.width,
                                height: 0.10 * MediaQuery.of(context).size.height,
                                child: CircularProgressIndicator(
                                  strokeWidth: 16.0,
                                  value: _circularProgressController.value,
                                  // value: Tween<double>(begin: 0.0, end: 0.8).animate(CurvedAnimation(parent: _circularProgressController, curve: Curves.bounceOut)).value,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10.0,),
                                  Text('Important Categories'),
                                ],
                              ),
                              SizedBox(height: 5.0,),
                              Align(child: Text(recentStats[scienceStat] == null ? 'science: no value' : 'science: ${recentStats[scienceStat]! * 100}'), alignment: Alignment.centerLeft,),
                              SizedBox(
                                width: 0.45 * MediaQuery.of(context).size.width,
                                height: 0.02 * MediaQuery.of(context).size.height,
                                child: RoundRectIndicator(
                                  value: 0.5,
                                  radius: 15.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                                ),
                              ),
                              SizedBox(height: 2.0,),
                              Align(child: Text('History: 80%'), alignment: Alignment.centerLeft,),
                              SizedBox(
                                width: 0.45 * MediaQuery.of(context).size.width,
                                height: 0.02 * MediaQuery.of(context).size.height,
                                child: RoundRectIndicator(
                                  value: 0.5,
                                  radius: 15.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                                ),
                              ),
                              SizedBox(height: 2.0,),
                              Align(child: Text('Geography: 80%'), alignment: Alignment.centerLeft,),
                              SizedBox(
                                width: 0.45 * MediaQuery.of(context).size.width,
                                height: 0.02 * MediaQuery.of(context).size.height,
                                child: RoundRectIndicator(
                                  value: 0.5,
                                  radius: 15.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                                ),
                              ),
                              Align(child: Text('Entertainment: 80%'), alignment: Alignment.centerLeft,),
                              SizedBox(
                                width: 0.45 * MediaQuery.of(context).size.width,
                                height: 0.02 * MediaQuery.of(context).size.height,
                                child: RoundRectIndicator(
                                  value: 0.5,
                                  radius: 15.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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

