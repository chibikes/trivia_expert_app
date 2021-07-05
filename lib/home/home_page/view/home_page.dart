import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/game/multi_player/view/multi_player_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/widgets/bubble_button.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            children: [
              Card(
                elevation: 8.0,
                color: Color(0xff3771c8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/profile_avatar.svg',height: 70, width: 70,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 40.0),
                      child: Text(
                        'Username',
                        style: TextStyle(fontFamily: 'ShowCardGothic', color: Colors.white, fontSize: 20)),
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 8.0,
                          child: Row(children: [Icon(Icons.circle, color: Colors.amber,size: 20.0,), Text('8')],),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 8.0,
                      child: Row(children: [Icon(Icons.circle, color: Colors.purple,size: 20.0,), Text('8')],),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 16.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text('HIGH SCORE : 20', style: TextStyle(fontFamily: 'ShowCardGothic', color: Colors.black, fontSize: 20)),
                      SizedBox(height: 5.0,),
                      Text('Tasks', style: GoogleFonts.aleo(fontSize: 20, fontWeight: FontWeight.w900),),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.wine_bar_rounded, color: Colors.orange,),
                        Text('Win a participation trophy'),

                      ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wine_bar_rounded,  color: Colors.orange,),
                          Text('Win in all category')
                        ],
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 65,
                width: 0.80 * MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8.0),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.orange, width: 2.0)
                          )
                      ),
                      alignment: Alignment.topCenter,
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () {},
                    child: Stack(
                      // clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(style: BorderStyle.none, width: 0.0),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.orangeAccent
                            ),
                          ),
                        ),
                        Center(child: Text('PLAY', style: GoogleFonts.blackHanSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),))
                      ],
                    )
                ),
              ),
              SizedBox(height: 5,),
              BubbleButton(),

              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return SinglePlayerPage();
                    }));

                  },
                  child: Text('ONLINE'),

              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context, MaterialPageRoute(builder: (context) {
              //            return MultiPlayerPage();
              //       }));
              //     },
              //     child: Text('Play a Friend'),
              // )
            ],
          ),
    );
  }

  const Home();
}