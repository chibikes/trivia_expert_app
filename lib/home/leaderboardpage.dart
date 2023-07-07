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
  final _scrollController = ScrollController();
  double? bottomSheetHeight;

  // final _bottomSheetController = AnimationController(vsync: this);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          bottomSheetHeight = 0;
        });
      } else {
        if (_scrollController.position.pixels <= 50) {
          setState(() {
            bottomSheetHeight = null;
          });
        }
      }
    });
    super.initState();
  }

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
          elevation: 0.5,
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
                Text(
                  'Ends in ${state.time}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          )),
        ),
        backgroundColor: Colors.white70,
        body: state.leaderBoardStatus == LeaderBoardStatus.failed
            ? Center(
                child: Text(
                'Something went wrong',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ))
            : state.leaderBoardStatus == LeaderBoardStatus.fetching
                ? Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0XFF4E4E4c),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      context.read<LeaderBoardBloc>().add(GetUserId(id ?? ''));
                      return Future.delayed(
                        Duration(milliseconds: 300),
                      );
                    },
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.gameScores.length < 50
                            ? state.gameScores.length
                            : 50,
                        itemBuilder: (context, index) {
                          String name = state.gameScores[index]['userName'];
                          name = name.length > 20
                              ? name.replaceRange(17, name.length, '...')
                              : name;

                          return SizedBox(
                            height: 0.10 * MediaQuery.of(context).size.height,
                            child: Card(
                              color: state.gameScores[index]['userId'] ==
                                      context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .user
                                          ?.id
                                  ? Colors.blueGrey.shade100
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    index > 2
                                        ? Text(
                                            '${index + 1}',
                                            style: GoogleFonts.ultra(),
                                          )
                                        : Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${index + 1}',
                                                style: GoogleFonts.ultra(),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: index == 0
                                                  ? Colors.orange
                                                  : index == 1
                                                      ? Colors.grey
                                                      : Colors.blue[300],
                                            ),
                                          ),
                                    SizedBox(
                                      width: 0.10 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(state
                                              .gameScores[index]['avatarUrl']),
                                    ),
                                    SizedBox(
                                      width: 0.08 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                    Expanded(child: Text(name)),
                                    SizedBox(
                                      width: 0.17 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.trophy,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(
                                      width: 0.02 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                    Text(
                                      state.gameScores[index]['highScore']
                                          .toString(),
                                      style: GoogleFonts.ultra(
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  //TODO: put method in an isolate
}
