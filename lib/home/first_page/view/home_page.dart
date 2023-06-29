import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/online_single_player.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_cubit.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/power_up_container.dart';
import 'package:trivia_expert_app/widgets/score_card.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import '../../../get_image.dart';
import '../../../user_bloc/cubit/user_bloc.dart';
import '../../../widgets/category_card.dart';
import '../../../widgets/custom_banner.dart';
import '../../../widgets/camera_widget.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      switch (state.homeStatus) {
        case HomeStatus.failure_update:
          return Scaffold(body: Center(child: Text('something went wrong')));
        case HomeStatus.updated:
          return Column();
        case HomeStatus.fetched:
          return BlocListener<FirstPageCubit, FirstPageState>(
            listener: (context, state) {},
            child: ListView(
              children: [
                SizedBox(
                  height: 0.02 * data.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthenticationLogOutRequested());
                        },
                        child: Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black54,
                        )),
                    Center(
                        child: Stack(
                      children: [
                        Positioned(
                          left: 1.5,
                          top: 1.5,
                          child: Text(
                            'TRIVIA EXPERT',
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'TRIVIA EXPERT',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => EditProfile()));
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.black54,
                        )),
                  ],
                ),
                SizedBox(
                  height: data.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0.10 * data.width),
                  child: BlocBuilder<ShopCubit, ShopState>(
                      builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Animate(
                            onPlay: (controller) => controller.repeat(),
                            effects: [
                              ScaleEffect(
                                delay: Duration(seconds: 7),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.bounceInOut,
                                begin: Offset(1, 1),
                                end: Offset(1.15, 1.15),
                              )
                            ],
                            child: PowerUpContainer(
                              powerUpQty: state.blueCrystals.toString(),
                              powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const BlueCrystal(
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                              height: 0.03 * data.height,
                              width: 0.20 * data.width,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Animate(
                            onPlay: (controller) => controller.repeat(),
                            effects: [
                              ScaleEffect(
                                delay: Duration(seconds: 9),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.bounceInOut,
                                begin: Offset(1, 1),
                                end: Offset(1.15, 1.15),
                              )
                            ],
                            child: PowerUpContainer(
                              powerUpQty: state.redCrystals.toString(),
                              powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const RedLifeCrystal(
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                              height: 0.03 * data.height,
                              width: 0.20 * data.width,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Animate(
                            onPlay: (controller) => controller.repeat(),
                            effects: [
                              ScaleEffect(
                                delay: Duration(seconds: 11),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.bounceInOut,
                                begin: Offset(1, 1),
                                end: Offset(1.15, 1.15),
                              )
                            ],
                            child: PowerUpContainer(
                              powerUpQty: state.rightAnswers.toString(),
                              powerUpIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const RightAnswer(
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                              height: 0.03 * data.height,
                              width: 0.20 * data.width,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: data.height * 0.01),
                SizedBox(
                  width: data.width,
                  height: 200,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
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
                                              .photoUrl ??
                                          altImage),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 65.0,
                        left: 230.0,
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.message),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          },
                          child: CustomPaint(
                            size: Size(25, 20),
                            painter: CameraIcon(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 115,
                        left: 95,
                        child: CustomBanner(
                          height: 100,
                          width: 250,
                          content: context.read<UserBloc>().state.user!.name ??
                              context.read<UserBloc>().state.user!.email ??
                              'Unknown User',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: data.height * 0.05,
                ),
                ScoreCard(),
                SizedBox(
                  height: data.height * 0.12,
                ),
                SizedBox(
                  height: 65,
                  width: 0.80 * data.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Shimmer(
                      child: RoundRectBubbleButton(
                        text: 'Play',
                        onPressed: () {
                          // return showSelectionDialog();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OnlineSinglePlayer();
                              },
                            ),
                          );
                        },
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
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: data.width * 0.1, top: data.height * 0.40),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
      }
    });
  }

  showSelectionDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: CategoryCard(
              height: 350,
              width: 200,
            ),
          );
        });
  }
}
