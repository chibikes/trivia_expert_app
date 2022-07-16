import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import 'online_single_player/view/online_single_player.dart';

class TipPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TipPageState();
  }
}

class TipPageState extends State<TipPage>
    with TickerProviderStateMixin {
  List<String> tips = ['Answering 10  successive questions correctly gives you 10 XP points', 'Buy power ups from the store section', 'Blue Crystals can be used in the store to purchase power ups. Use them!'];
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
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 0.30 * MediaQuery.of(context).size.width,),
                Text('CLASSIC TRIVIA', style: TextStyle(color: Colors.blueGrey,fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(width: 0.10 * MediaQuery.of(context).size.width,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(backgroundColor: Colors.cyan,onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close), elevation: 3.0,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.only(
                  right: 0.70 * MediaQuery.of(context).size.width),
              child: Transform.rotate(
                angle: -0.5,
                child: Text(
                  'TIPS',
                  style: GoogleFonts.droidSans(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3.0),
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 8.0),],
                color: Color(0xff008080),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 0.40 * MediaQuery.of(context).size.height,
              width: 0.70 * MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeTransition(opacity: Tween<double>(begin: 1.0, end: 0.30).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn)),
                child: Text(tips[tipIndex], style: GoogleFonts.balooDa(color: Colors.white, fontSize: 15))),
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
          ],
        ),
      ),
    );
  }

  _pressButton() async {
    pressButtonSound();
    await _buttonController.forward();
    await _buttonController.reverse();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OnlineSinglePlayer();
    }));
  }

  void pressButtonSound() {
    final audioPlayer = AudioCache();
    audioPlayer.play('button_click.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}
