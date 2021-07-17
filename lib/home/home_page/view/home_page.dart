import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/game/multi_player/view/multi_player_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/widgets/bubble_button.dart';
import 'package:trivia_expert_app/widgets/check_mark_widget.dart';
import 'package:trivia_expert_app/widgets/cyrstal.dart';
import 'package:trivia_expert_app/widgets/first_aid_box.dart';
import 'package:trivia_expert_app/widgets/roundrect_bubble_button.dart';

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
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.circular(3.0),
              gradient: LinearGradient(begin: Alignment(0.2, 0.0), colors: [
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
                      SvgPicture.asset(
                        'assets/profile_avatar.svg',
                        height: 70,
                        width: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Icon(
                          Icons.photo_camera_rounded,
                          color: Colors.green,
                        ),
                      )
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
                Crystal(
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
                  child: FirstAidBox(
                    height: 25,
                    width: 25,
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
                      colors: [Colors.green, Colors.lightGreen])),
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
          scale: Tween<double>(begin: 1.0, end: 0.70).animate(CurvedAnimation(
              parent: _bounceController!, curve: Curves.bounceInOut)),
          child: SizedBox(
            height: 65,
            width: 0.80 * MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: RoundRectBubbleButton(
                text: 'Play',
                onPressed: () => animateButton(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 5,
              ),
              BubbleButton(),
              SizedBox(
                width: 5,
              ),
              BubbleButton(),
              SizedBox(
                width: 5,
              ),
              BubbleButton(),
              SizedBox(
                width: 5,
              ),
              BubbleButton(),
            ],
          ),
        ),
        Card(
          child: Text('Column'),
        )
      ],
    );
  }

  void animateButton() async {
    await _bounceController
        ?.forward()
        .whenComplete(() => _bounceController?.reverse());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SinglePlayerPage();
    }));
  }
}
