import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rive/rive.dart';
import 'package:trivia_expert_app/game/single_player/animations.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/widgets/banner.dart';
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

  late QuestionBloc _questionBloc;
  late Timer _timer;
  int _start = 10;
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
                      // Animated
                      Padding(padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.alarm, size: 30, color: Colors.orange,),
                            Text('$_start'),
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
                            // Icon(Icons.accessibility, size: 30.0, color: Colors.red,),
                            FaIcon(FontAwesomeIcons.heart, size: 30.0, color: Colors.red,)

                          ],

                        ),
                      ),
                      SizedBox(height: 20,),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.20 * MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Padding(padding: EdgeInsets.all(8.0),
                                child: Text(state.questions[index].question!, style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ),
                          )
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
                      SizedBox(height: state.answers[index][0] == '' ? 0 : 20),
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
                      SizedBox(height: state.answers[index][1] == '' ? 0 : 20),
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
                      SizedBox(height: state.answers[index][2] == '' ? 0 : 20),
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
              _start--;
            });
          }
        }
    );
  }
  void validateAnswer(String? value, int tapped) {
    if (!isButtonTapped) {
      AnimationController? _controllerx;
      switch (tapped) {
        case 0:
          _controllerx = AnimationHelper.controllerOne;
          break;
        case 1:
          _controllerx = AnimationHelper.controllerTwo;
          break;
        case 2:
          _controllerx = AnimationHelper.controllerThree;
          break;
        case 3:
          _controllerx = AnimationHelper.controllerFour;
          break;
      }
      isButtonTapped = true;
      _questionBloc = context.read<QuestionBloc>();
      correctAnswer = _questionBloc.state.questions[index].correctAnswer;
      if (value == correctAnswer) {
        updateProgress();
        setState(() {
          qAnswered++;
          _playAnimation(_controllerx);
        });
      } else {
        // you only need to fail once and that's all for you
        setState(() {
          listBol[tapped] = false;
          _timer.cancel();
        });
        _playAnimationFail(_controllerx);

      }
    }
  }

  void updateState() {
    index++;
    fetchQuestions();
    _start = 10;
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
        Navigator.of(context).pop();
      });
      // Navigator.of(context).pop();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }


}