import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/learderboard_bloc/bloc/leaderboard_event.dart';
import 'package:trivia_expert_app/learderboard_bloc/bloc/leaderboard_state.dart';
import 'package:trivia_expert_app/user_bloc/cubit/user_bloc.dart';
import '../learderboard_bloc/bloc/leaderboard_bloc.dart';
import '../widgets/trophy_cup_layer.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  State<LeaderBoardPage> createState() {
    return LeaderBoardPageState();
  }
}

class LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    var id = context.read<AuthenticationBloc>().state.user!.id;
    context.read<LeaderBoardBloc>().add(GetUserId(id ?? ''));
    return BlocBuilder<LeaderBoardBloc, LeaderBoardState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.12 * MediaQuery.of(context).size.height,
          backgroundColor: Color(0xfff8f0e3),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Icon(
                      FontAwesomeIcons.trophy,
                      color: Colors.green,
                      size: 30,
                    ),
                    Positioned(
                      top: 3.0,
                      left: 5.5,
                      child: CustomPaint(
                        painter: TrophyLayerPainter(),
                        size: Size(23, 20),
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 20.0,
                      child: Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                            color: Colors.white24, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Leader Board',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
          )),
        ),
        backgroundColor: Colors.white70,
        body: state.leaderBoardStatus == LeaderBoardStatus.failed
            ? Center(child: Text('Something went wrong', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),))
            : state.leaderBoardStatus == LeaderBoardStatus.fetching
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: state.gameScores.length < 50 ? state.gameScores.length : 50,
                    itemBuilder: (context, index) {
                      String name = state.gameScores[index]['userName'];
                      name = name.length > 20
                          ? name.replaceRange(17, name.length, '...')
                          : name;

                      return SizedBox(
                        height: 0.10 * MediaQuery.of(context).size.height,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: GoogleFonts.ultra(),
                                ),
                                SizedBox(
                                  width:
                                      0.10 * MediaQuery.of(context).size.width,
                                ),
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      state.gameScores[index]['avatarUrl']),
                                ),
                                SizedBox(
                                  width:
                                      0.08 * MediaQuery.of(context).size.width,
                                ),
                                Expanded(child: Text(name)),
                                SizedBox(
                                  width:
                                      0.17 * MediaQuery.of(context).size.width,
                                ),
                                Icon(
                                  FontAwesomeIcons.trophy,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  width:
                                      0.02 * MediaQuery.of(context).size.width,
                                ),
                                Text(
                                  state.gameScores[index]['highScore']
                                      .toString(),
                                  style:
                                      GoogleFonts.ultra(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
        bottomSheet: BottomSheet(
          builder: (BuildContext context) {
            var user = context.read<UserBloc>().state.user;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    state.position.toString(),
                    style: GoogleFonts.ultra(),
                  ),
                  SizedBox(
                    width: 0.10 * MediaQuery.of(context).size.width,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(user!.photoUrl!),
                  ),
                  SizedBox(
                    width: 0.08 * MediaQuery.of(context).size.width,
                  ),
                  Expanded(child: Text(user.name!)),
                  SizedBox(
                    width: 0.17 * MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    width: 0.02 * MediaQuery.of(context).size.width,
                  ),
                  Text(
                    '${context.read<UserBloc>().state.gameDetails.highScore}',
                    style: GoogleFonts.ultra(color: Colors.blueGrey),
                  ),
                ],
              ),
            );
          },
          onClosing: () {},
          backgroundColor: Color(0xfff8f0e3),
        ),
      );
    });
  }
  //TODO: put method in an isolate

}
