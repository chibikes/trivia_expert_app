import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

import '../../widgets/power_up_container.dart';
import 'online_single_player/view/online_single_player.dart';

class SinglePlayerPage extends StatefulWidget {
  /// should have win lose or initial so if you fail in game play you'll come back here with a state of lose

  @override
  State<StatefulWidget> createState() {
    return SinglePlayerPageState();
  }
}

class SinglePlayerPageState extends State<SinglePlayerPage>
    with TickerProviderStateMixin {
  List<String> tips = ['Answering 10 Successive questions unlocks a new level with some reward', 'Buy power ups from the store section', 'Blue Crystals can be used in the store to purchase power ups. Use them!'];
  var tipIndex = 0;
  late AnimationController _buttonController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 50));
  late AnimationController _fadeController = AnimationController(vsync: this, duration: Duration(seconds: 5));

  @override
  void initState() {

    _fadeController.addStatusListener((status) {
      if(status == AnimationStatus.reverse) {
        setState(() {
          tipIndex == tips.length - 1 ? tipIndex = 0 : tipIndex++;
        });
      }
    });
    _fadeController.forward();
    _fadeController.repeat(reverse: true);

    super.initState();
  }
  @override
  void dispose() {
    _buttonController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: 0.70 * MediaQuery.of(context).size.width),
              child: Transform.rotate(
                angle: -0.5,
                child: Text(
                  'TIP',
                  style: GoogleFonts.droidSans(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8.0),],
                color: Color(0xff008080),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 0.40 * MediaQuery.of(context).size.height,
              width: 0.70 * MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeTransition(opacity: Tween<double>(begin: 1.0, end: 0.30).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn)),
                child: Text(tips[tipIndex], style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            ProperElevatedButton(
              // tapUpFunction: () =>_longPressButton(),
              // tapDownFunction: (details) => _longPressStop(),
              function: () => _pressButton(),
              buttonHeight: 50.0,
              buttonWidth: 0.85, text: 'Play',
              position:
                  Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.12))
                      .animate(CurvedAnimation(
                          parent: _buttonController, curve: Curves.linear)),
            ),
            Text('TRIVIA'),
          ],
        ),
      ),
    );
  }

  _pressButton() async {
    await _buttonController.forward();
    await _buttonController.reverse();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OnlineSinglePlayer();
    }));
  }
  _longPressButton() {
    _buttonController.forward();
  }

  _longPressStop() {
    _buttonController.reverse();
  }
}
