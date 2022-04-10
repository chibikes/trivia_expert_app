import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoardPage extends StatefulWidget{
  @override
  State<LeaderBoardPage> createState() {
    return LeaderBoardPageState();
  }
}

/// just daily leaderboard.
class LeaderBoardPageState extends State<LeaderBoardPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('highScores')
      // .orderBy('dailyScore', descending: true)
      .limit(1)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['userName']),
                subtitle: Text(data['highScore']),
              );
            }).toList(),
          );
        }
    ),
    );
  }
}