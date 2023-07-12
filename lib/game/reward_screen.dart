import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_page.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/online_single_player.dart';

import '../ad_helper.dart';
import '../questions/bloc/question_bloc.dart';
import '../widgets/stacked_button.dart';

class RewardScreen extends StatefulWidget {
  final int lastScore;
  final int score;
  final Map stats;
  final bool newLevel;
  final bool highScoreEvent;
  final double reward;

  const RewardScreen(
      {Key? key,
      required this.lastScore,
      required this.score,
      required this.stats,
      required this.newLevel,
      required this.highScoreEvent,
      required this.reward})
      : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    _loadRewardedAd();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 0.1 * MediaQuery.of(context).size.height,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              StackedButtons(
                  xHeight: 3,
                  height: 25,
                  width: 25,
                  borderRadius: 24.0,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPress: () {
                    Navigator.pop(context);
                    // return finished game page
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FinishedGame(
                          score: widget.score,
                          newLevel: widget.newLevel,
                          reward: widget.reward,
                          highScore: widget.highScoreEvent,
                          stats: widget.stats);
                    }));
                  }),
            ],
          ),
          SizedBox(
            height: 0.1 * MediaQuery.of(context).size.height,
          ),
          Text(
            'Want to Continue Your Streak?',
            style: GoogleFonts.droidSans(
              fontSize: 25,
              color: Colors.orange,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'Watch a video to resume playing',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Center(
            child: StackedButtons(
              height: 50,
              width: 0.80 * MediaQuery.of(context).size.width,
              topColor: Color(0xffd45500),
              bottomColor: Color(0xffd45500),
              child: SizedBox(
                width: 0.30 * MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          // Icon(FontAwesomeIcons.video),
                          Text(
                            'Continue',
                            style: GoogleFonts.blackHanSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onPress: () {
                _rewardedAd?.show(onUserEarnedReward: (_, reward) {
                  context.read<QuestionBloc>().add(FetchQuestions());
                  context
                      .read<OnlineSinglePlayerCubit>()
                      .resetGameState(score: widget.lastScore);
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OnlineSinglePlayer();
                  }));
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        }, onAdFailedToLoad: (err) {
          print('Failed to load ad');
        }));
  }
}
