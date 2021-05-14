
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/game/game.dart';
import 'package:trivia_expert_app/game/multi_player/view/multi_player_page.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {

                    },
                    child: Text('Build in progress'),
                ),
                TextButton(onPressed: () {},
                    child: Text('Build in progress'))
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              child: Text('IT'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) {
                    return SinglePlayerPage();
                  }));

                },
                child: Text('ONLINE'),

            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) {
                       return MultiPlayerPage();
                  }));
                },
                child: Text('Play a Friend'),
            )
          ],
        );
  }

  const Home();
}