import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BubbleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.33 * MediaQuery.of(context).size.width,
      height: 0.33 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // gradient: LinearGradient(colors: [Colors.blue, Color(0xff022f8e), Colors.blue]),
        border: Border.all(color: Colors.lightBlueAccent),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 5,),
          Stack(
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
              Text('Player 1', style: GoogleFonts.aladin(fontSize: 20.0),)
            ],
          ),
          Center(child: CircleAvatar(child: Text('Ima'),),),
          SizedBox(height: 15.0,),
          SizedBox(
            height: 25.0,
            child: ElevatedButton(
              style: ButtonStyle(
                // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 0.0)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
                onPressed: () {},
                child: Text('Play', style: TextStyle(color: Colors.black),)
            ),
          )
        ],
      ),
    );
  }

}