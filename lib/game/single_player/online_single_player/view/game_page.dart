import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rive/rive.dart';
import 'package:trivia_expert_app/game/single_player/animations.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/widgets/banner.dart';
import 'package:trivia_expert_app/widgets/chalkboard.dart';
import 'package:trivia_expert_app/widgets/clock.dart';
import 'package:trivia_expert_app/widgets/custom_button.dart';
import 'package:trivia_expert_app/widgets/styles.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePageState();


}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late final AnimationController? _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final AnimationController? _cardController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
  );
  late double chalkBoardWidth = 0.85 * MediaQuery.of(context).size.width;
  late double chalkBoardHeight = chalkBoardWidth/1.6180;
  late QuestionBloc _questionBloc;
  late Timer _timer;
  int _start = 30;
  int _totalTime = 30;
  Result? results;
  int index = 0;
  List<Color> colors = [
    Colors.blue,Colors.blue,
    Colors.blue, Colors.blue,
  ];
  List<String>? answers = [];
  String? correctAnswer;

  Artboard? _artboard;
  final landscapeFile = 'assets/landscape.riv';
  int qAnswered=0, qFailed=0;
  var listBol = [true, true, true, true];

  static bool isButtonTapped = false;
  bool notFailed = true;

  void _loadRiveFile() async {
    await rootBundle.load(landscapeFile).then((data) {
      final file = RiveFile.import(data);

      setState(() =>
      _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('moving_clouds'),
        ));
    });

  }
  @override
  void initState() {
    isButtonTapped = false;
    AnimationHelper.controllerFour = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerThree = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerTwo = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerOne = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _loadRiveFile();
    fetchQuestions();
    startTimer();
    _controller?.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          switch(state.status) {
            case QuestionStatus.failure:
              return const Center(child: Text('failed to connect to the internet'));
            case QuestionStatus.success:
              return Stack(
                children: [
                  _artboard != null
                      ? Rive(
                    artboard: _artboard!,
                    fit: BoxFit.cover,

                  )
                      :
                  Container(

                  ),

                  Column(
                    children: [
                      Text('category: ' +state.questions[index].category!),
                      // Animated
                      Padding(padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Clock(
                              width: 50.0,
                              height: 40.0,
                              widget: Text(
                                '$_start',
                                style: GoogleFonts.aladin(fontWeight: FontWeight.w400, fontSize: 15),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                                width: 200,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.lightBlue,
                                  minHeight: 50,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.indigo
                                  ),
                                  value: (qAnswered.abs()/10),
                                )
                            ),
                            FaIcon(FontAwesomeIcons.solidHeart, size: 30.0, color: Colors.red,)

                          ],

                        ),
                      ),
                      SizedBox(height: 20,),
                      ChalkBoard(
                        height: chalkBoardHeight,
                        width: chalkBoardWidth,
                        widget: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                          child: Text(state.questions[index].question!,
                            style: GoogleFonts.aleo(
                                textStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 50,),
                      SlideTransition(
                        position: Tween<Offset>(begin: Offset.zero, end: Offset(3.5, 0.0)).animate(CurvedAnimation(
                            parent: _controller!,
                            curve: Interval(0.0, 1.0, curve: Curves.elasticIn  ))),
                        child: GestureDetector(
                          onTap: () => validateAnswer(state.answers[index][0], 0),
                          child: CustomButton(
                            isAnswerEmpty: state.answers[index][0] == '',
                            animationController: AnimationHelper.controllerOne,
                            notFailed: listBol[0],
                            child: Text(state.answers[index][0], style: MyTextStyle.style),
                          ),
                        ),
                      ),
                      SizedBox(height: state.answers[index][0] == '' ? 0 : 10),
                      SlideTransition(
                          position: Tween<Offset>(begin: Offset.zero, end: Offset(3.5, 0.0)).animate(CurvedAnimation(
                              parent: _controller!,
                              curve: Interval(0.25, 1.0, curve: Curves.elasticIn  ))),
                          child: GestureDetector(
                              onTap: () => validateAnswer(state.answers[index][1], 1),
                              child:CustomButton(
                                isAnswerEmpty: state.answers[index][1] == '',
                                animationController: AnimationHelper.controllerTwo,
                                notFailed: listBol[1],
                                child: Text(state.answers[index][1], style: MyTextStyle.style,),
                              )
                          )
                      ),
                      SizedBox(height: state.answers[index][1] == '' ? 0 : 10),
                      SlideTransition(
                          position: Tween<Offset>(begin: Offset.zero, end: Offset(3.5, 0.0)).animate(CurvedAnimation(
                              parent: _controller!,
                              curve: Interval(0.50, 1.0, curve: Curves.elasticIn  ))),
                          child: GestureDetector(
                            onTap: () => validateAnswer(state.answers[index][2], 2),
                            child:CustomButton(
                              isAnswerEmpty: state.answers[index][2] == '',
                              animationController: AnimationHelper.controllerThree,
                              notFailed: listBol[2],
                              child: Text(state.answers[index][2], style: MyTextStyle.style,),

                            ),)
                      ),
                      SizedBox(height: state.answers[index][2] == '' ? 0 : 10),
                      SlideTransition(
                          position: Tween<Offset>(begin: Offset.zero, end: Offset(3.5, 0.0)).animate(CurvedAnimation(
                              parent: _controller!,
                              curve: Interval(0.75, 1.0, curve: Curves.elasticIn  ))),
                          child:GestureDetector(
                            onTap: () => validateAnswer(state.answers[index][3], 3),
                            child:CustomButton(
                              isAnswerEmpty: state.answers[index][3] == '',
                              animationController: AnimationHelper.controllerFour!,
                              child: Text(state.answers[index][3], style: MyTextStyle.style),
                              notFailed: listBol[3],
                            ),
                          )
                      ),
                      SizedBox(height: 30,),
                      FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _cardController!, curve: Curves.linear)),
                        child: Card(
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('1. Answer all questions in the science category\n '),
                                Text('2. Beat the threshold time: that is score 30 > 40'),
                              ],
                            ),
                          ),
                          elevation: 8.0,
                        ),
                      )
                    ],
                  ),
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());

          }
        }
    );

  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) {
          if (_start == 0) {
            setState(() {
              AnimationHelper.startAnimationFour = true;
              _timer.cancel();
              Navigator.pop(context);
            });
          } else {
            setState(() {
              _start % (_totalTime/3) == 0
                  ? _cardController?.forward().whenComplete(() => {_cardController?.reverse()})
                  : {};
              _start--;

            });
          }
        }
    );
  }
  void validateAnswer(String? value, int tapped) {
    if (!isButtonTapped) {
      AnimationController? _controllerX;
      switch (tapped) {
        case 0:
          _controllerX = AnimationHelper.controllerOne;
          break;
        case 1:
          _controllerX = AnimationHelper.controllerTwo;
          break;
        case 2:
          _controllerX = AnimationHelper.controllerThree;
          break;
        case 3:
          _controllerX = AnimationHelper.controllerFour;
          break;
      }
      isButtonTapped = true;
      _questionBloc = context.read<QuestionBloc>();
      correctAnswer = _questionBloc.state.questions[index].correctAnswer;
      if (value == correctAnswer) {
        updateProgress();
        setState(() {
          qAnswered++;
          _playAnimation(_controllerX);
        });
      } else {
        // you only need to fail once and that's all for you
        setState(() {
          listBol[tapped] = false;
          _playAnimation(_controllerX);
        }); 


      }
    }
  }

  void updateState() {
    index++;
    // _cardController?.forward().whenComplete(() {
    //   _cardController?.reverse();
    // });
    listBol = [true, true, true, true];
    fetchQuestions();
  }

  void updateProgress() {
    if (qAnswered == 10) {
      Navigator.pop(context);
      _timer.cancel();
    }
  }


  @override
  void dispose() {
    _timer.cancel();
    _controller?.dispose();
    _cardController?.dispose();
    AnimationHelper.controllerOne?.dispose();
    AnimationHelper.controllerTwo?.dispose();
    AnimationHelper.controllerThree?.dispose();
    AnimationHelper.controllerFour?.dispose();
    super.dispose();
  }

  void fetchQuestions()  {
    if(index == 9) {
      QuestionsFetched.offSet+= 10;
      _questionBloc.add(QuestionsFetched());
      index = 0;
    }
  }

  Future<void> _playAnimation(AnimationController? colorController) async {
    try {
      await colorController!.forward().then((value) {
      });
      await _controller!.forward().whenComplete(() {
        updateState();
      });
      await colorController.reverse(); /// the secret of this smooth animation is in the awaits :-). I discovered it by accident

      await _controller!.reverse().whenComplete(() {
        isButtonTapped = false;
      });

    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }
  Future<void> _playAnimationFail(AnimationController? colorController) async {
    try {
      await colorController!.forward().whenComplete(() {
        colorController.reverse();
      });
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }


}