import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rive/rive.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/widgets/banner.dart';

class GamePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }


}

class _GamePageState extends State {
  bool disableButton = false;
  QuestionBloc _questionBloc;
  Timer _timer;
  int _start = 10;
  Result results;
  int index = 0;
  List<Color> colors = [
    Colors.blue,Colors.blue,
    Colors.blue,Colors.blue
  ];
  // List<String> answers; // TODO: don't forget to use this
  String correctAnswer;

  Artboard _artboard;
  final landscapeFile = 'assets/landscape.riv';

  int qAnswered=0, qFailed=0;

  bool ansIsCorrect;


  void _loadRiveFile() async {
    final bytes = await rootBundle.load(landscapeFile);
    final file = RiveFile();

    if(file.import(bytes)) {

      setState(() =>
      _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('moving_clouds'),
        ));
    }
  }
  @override
  void initState() {
    _loadRiveFile();
    fetchQuestions();
    startTimer();
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
                    artboard: _artboard,
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
                          Text('$_start'),
                          Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: LinearProgressIndicator(
                                minHeight: 50,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green
                                ),
                                value: (qAnswered.abs()/15),
                              )
                          )

                        ],
                      )),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child:
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.20 * MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(

                          color: Colors.white,
                        ),
                        child: Padding(padding: EdgeInsets.all(8.0),
                            child: Text(state.questions[index].question)
                        ),
                      )
                      ),

                      SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () => {

                            validateAnswer(
                                state.questions[index].incorrectOne, colors[0])
                        },
                        child: Text(state.questions[index].incorrectOne),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(colors[0]),
                        ),
                      ),
                      ElevatedButton(
                        onPressed:() => validateAnswer(state.questions[index].incorrectTwo, colors[1]),
                        child: Text(state.questions[index].incorrectTwo),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(colors[1])),
                      ),

                      ElevatedButton(
                        onPressed: () => validateAnswer(state.questions[index].incorrectThree, colors[2]),
                        child: Text(state.questions[index].incorrectThree),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(colors[2])),
                      ),
                      ElevatedButton(
                        onPressed: () => validateAnswer(state.questions[index].correctAnswer, colors[3]),
                        child: Text(state.questions[index].correctAnswer),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(colors[3])),
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
   void validateAnswer(String value, Color color) {
     if (!disableButton) {
       _questionBloc = context.read<QuestionBloc>();
       correctAnswer = _questionBloc.state.questions[index].correctAnswer;
       if (value == correctAnswer) {
         setState(() {
           updateState();
           updateProgress();
           qAnswered++;
           color = Colors.green;
         });
       } else {
         disableButton = true;
         setState(() {
           _timer.cancel();
           Navigator.of(context).pop();
           color = Colors.red;
           updateState();
           updateProgress();
         });
       }
     }
   }

   void updateState() {
     index++;
     fetchQuestions();
     _start = 10;
   }

   void updateProgress() {
    if (qAnswered == 15) {
      Navigator.pop(context);
      _timer.cancel();
    }
   }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void fetchQuestions()  {
    if(index == 9) {
      QuestionsFetched.offSet+= 10;
      _questionBloc.add(QuestionsFetched());
      index = 0;
    }
  }

}