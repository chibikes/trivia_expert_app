import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:trivia_expert_app/home/first_page/profile_page/view/profile_page.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/power_up_container.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import 'package:trivia_expert_app/widgets/xp_icon.dart';
import '../../../get_image.dart';
import '../../../user_bloc/cubit/user_bloc.dart';
import '../../../widgets/camera_widget.dart';
import '../../../widgets/trophy_cup_layer.dart';
import '../profile_page/view/edit_profile/edit_profile.dart';

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
  late AnimationController _circularProgressController = AnimationController(
    lowerBound: 0.0,
    upperBound: GamingStats.recentStats[accuracyStat]?.toDouble() ?? 0.0,
    vsync: this,
    duration: Duration(seconds: 3),
  );
  @override
  void initState() {
    _circularProgressController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(seconds: 5))
        .then((value) => _circularProgressController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      switch (state.homeStatus) {
        case HomeStatus.failure_update:
          return Center(child: Text('something went wrong'));
        case HomeStatus.updated:
          return Column(
            // children: [
            //   Text(context.read<UserBloc>().state.user!.age ?? 'null'),
            //   ElevatedButton(
            //     onPressed: () {
            //       context.read<FirstPageCubit>().goToPage(
            //             context,
            //             ProfilePage(
            //               context: context,
            //             ),
            //           );
            //     },
            //     child: Text('Go to ->'),
            //   )
            // ],
          );
        case HomeStatus.fetched:
          startAnimation();
          return BlocListener<FirstPageCubit, FirstPageState>(
            listener: (context, state) {},
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(onTap: () {context.read<AuthenticationBloc>().add(AuthenticationLogOutRequested());},child: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black54,)),
                    Center(
                        child: Text(
                      'TRIVIA EXPERT',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                    ),
                    GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditProfile()));},child: Icon(Icons.settings, color: Colors.black54,)),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: BlocBuilder<ShopCubit, ShopState>(
                      builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: PowerUpContainer(
                            powerUpQty: state.blueCrystals.toString(),
                            powerUpIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BlueCrystal(
                                  height: 12,
                                  width: 12,
                                ),
                              ],
                            ),
                            height: 0.04 * MediaQuery.of(context).size.height,
                            width: 0.25 * MediaQuery.of(context).size.width,
                          ),
                        ),
                        Expanded(
                          child: PowerUpContainer(
                            powerUpQty: state.redCrystals.toString(),
                            powerUpIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RedLifeCrystal(
                                  height: 12,
                                  width: 12,
                                ),
                              ],
                            ),
                            height: 0.04 * MediaQuery.of(context).size.height,
                            width: 0.25 * MediaQuery.of(context).size.width,
                          ),
                        ),
                        Expanded(
                          child: PowerUpContainer(
                            powerUpQty: state.rightAnswers.toString(),
                            powerUpIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RightAnswer(
                                  height: 12,
                                  width: 12,
                                ),
                              ],
                            ),
                            height: 0.04 * MediaQuery.of(context).size.height,
                            width: 0.25 * MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    );
                  }),
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
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.deepPurple],
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(blurRadius: 2.0, color: Colors.black38)
                          ],
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 42.0,
                                backgroundImage: CachedNetworkImageProvider(
                                    context
                                        .read<UserBloc>()
                                        .state
                                        .user!
                                        .photoUrl ?? altImage),

                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 70.0,
                          left: 73.0,
                          child: GestureDetector(
                              onTap: () async {
                                try {
                                  var file = await context
                                      .read<FirstPageCubit>()
                                      .retrieveImage();
                                  context
                                      .read<UserBloc>()
                                      .add(UpdateUserImage(file));
                                } on ImageTooLargeException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message), behavior: SnackBarBehavior.floating,));
                                }
                              },
                              child: CustomPaint(
                                size: Size(25, 20),
                                painter: CameraIcon(),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Color(0xffffd700), width: 2.0)),
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
                      GestureDetector(
                        onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_){return EditProfile();}));},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                              badgeContent: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 10,
                              ),
                              child: Text(
                                context.read<UserBloc>().state.user!.name ??
                                    context.read<UserBloc>().state.user!.email ??
                                    'User Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xff8b5a2b)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.trophy,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                    Positioned(
                                      top: 3.0,
                                      left: 5.5,
                                      child: CustomPaint(
                                        painter: TrophyLayerPainter(),
                                        size: Size(23, 20),
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
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${GamingStats.recentStats[highScore]}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70),
                                    ),
                                    Text(
                                      'High Score',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 2.0,
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomPaint(
                                    painter: XPPainter(
                                      Colors.blue,
                                      Colors.lightBlue,
                                    ),
                                    size: Size(28, 35)),
                                Column(
                                  children: [
                                    Text(
                                      '${GamingStats.recentStats[gameLevel]}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70),
                                    ),
                                    Text(
                                      'XP',
                                      style: GoogleFonts.alegreyaSans(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
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
                                  buttonController: _bounceController,
                                ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
