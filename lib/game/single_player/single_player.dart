import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';


import 'online_single_player/view/online_single_player.dart';

class SinglePlayerPage extends StatefulWidget { /// should have win lose or initial so if you fail in game play you'll come back here with a state of lose

  @override
  State<StatefulWidget> createState() {
    return SinglePlayerPageState();
  }

}

class SinglePlayerPageState extends State<SinglePlayerPage> with TickerProviderStateMixin {
  late AnimationController _buttonController = AnimationController(vsync: this, duration: Duration(milliseconds: 50));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CircleAvatar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    CircularPads(radius: 50.0,text: '',),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FaIcon(Icons.info_outline, size: 18,),
                    ),
                  ],
                ),
                SizedBox(width: 5.0,),
                Stack(
                  children: [
                    CircularPads(radius: 50.0,text: '',),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FaIcon(Icons.info_outline, size: 18,),
                    ),
                  ],
                ),
                SizedBox(width: 20.0,)
              ],
            ),
            SizedBox(height: 100,),
            Padding(
              padding:  EdgeInsets.only(right: 0.70 * MediaQuery.of(context).size.width),
              child: Transform.rotate(angle: -0.5,child: Text('TIP', style: GoogleFonts.droidSans(fontSize: 20, fontWeight: FontWeight.w800),)),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff008080),
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 0.40 * MediaQuery.of(context).size.height,
              width: 0.70 * MediaQuery.of(context).size.width,
              child: Card(
                color: Color(0xff008080),
                shape: Border.all(style: BorderStyle.none),
                child: Column(
                  children: [

                  ],
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            ProperElevatedButton(
              // tapUpFunction: () =>_longPressButton(),
              // tapDownFunction: (details) => _longPressStop(),
              function: () => _pressButton(),
              buttonHeight: 50.0,
              buttonWidth: 0.85,text: 'Play',
            position:  Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.12)).animate(CurvedAnimation(parent: _buttonController, curve: Curves.linear)),
            ),
            Text('TRIVIA'),
            //     ElevatedButton(
            //         onPressed: () {Navigator.push(
            //         context, MaterialPageRoute(builder: (context){
            //           return OnlineSinglePlayer();
            //         })
            //   );
            // },
            //         child: Text('Start')
            //     )
          ],
        ),
      ),
    );
  }

  _pressButton() async {
    await _buttonController.forward();
    await _buttonController.reverse();
    Navigator.push(
      context, MaterialPageRoute(builder: (context){
        return OnlineSinglePlayer();
      })
    );

  }
  _longPressButton() {
     _buttonController.forward();
  }
  _longPressStop() {
    _buttonController.reverse();
  }
}