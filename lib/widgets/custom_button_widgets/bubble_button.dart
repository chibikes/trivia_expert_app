import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/widgets/decorated_avatar.dart';

class BubbleButton extends StatelessWidget {
  final String? playerTwo;
  final bool? gameIsActive;
  final double? height;
  final double? width;
  final String? imgLoci;

  final Function? onTap;

  const BubbleButton(
      {Key? key,
      this.playerTwo,
      this.gameIsActive,
      this.height,
      this.width,
      this.imgLoci,
      this.onTap
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white, Colors.blue]),
          border: Border.all(color: Colors.lightBlueAccent),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, right: 3.0),
                      child: Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    height: 45,
                    width: 0.30 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.0, style: BorderStyle.none),
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  Text(
                    '$playerTwo',
                    style: GoogleFonts.aladin(fontSize: 20.0),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: CircleAvatar(
                  radius: 30.0,
                  child: DecoratedAvatar(
                    height: 0.7 * height!,
                    width: 0.7 * width!,
                  ),
                  backgroundImage:
                      NetworkImage(imgLoci ?? ''), // TODO: replace with a default image.

                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: SizedBox(
                height: 25.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 0.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Text(
                        gameIsActive! ? 'Play' : 'New game',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
