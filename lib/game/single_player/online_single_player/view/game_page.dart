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
  QuestionBloc _questionBloc;
  Timer _timer;
  int _start = 10;
  Result results;
  int index = 0;
  Color btnColor = Colors.blue; // default color for buttons
  List<int> indices = <int>[0,1,2];
  int randomVal;

  Artboard _artboard;
  final landscapeFile = 'assets/landscape.riv';

  var noOfquestionsAnswered;

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
    noOfquestionsAnswered = 0;
    _loadRiveFile();
    fetchQuestions();
    randomizeVal();
    indices.shuffle();
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
                                    noOfquestionsAnswered > 0 ?
                                    Colors.green :
                                    Colors.red
                                ),
                                value: (noOfquestionsAnswered.abs()/20),
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
                        onPressed: () => {checkAnswer(0)},
                        child: Text(randomVal == 0 ? state.questions[index].correctAnswer
                            : state.questions[index].incorrectAnswers[indices[0]] ?? ''),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
                      ),
                      ElevatedButton(
                        onPressed:() => checkAnswer(1),
                        child: Text(randomVal == 1 ? state.questions[index].correctAnswer
                            : state.questions[index].incorrectAnswers[indices[1]] ?? ''),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
                      ),

                      ElevatedButton(
                        onPressed: () => checkAnswer(2),
                        child: Text(randomVal == 2 ? state.questions[index].correctAnswer
                            : state.questions[index].incorrectAnswers[indices[2]] ?? ''),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
                      ),
                      ElevatedButton(
                        onPressed: () => checkAnswer(3),
                        child: Text(randomVal == 3 ? state.questions[index].correctAnswer
                            : state.questions[index].incorrectAnswers[indices[randomVal]] ?? ''),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
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
   void checkAnswer(int value) {
    if(value == randomVal) {
      setState(() {
        updateState();
        updateProgress();
        noOfquestionsAnswered++;
        btnColor = Colors.green;

      });
    } else {
      noOfquestionsAnswered--;
      btnColor = Colors.red;
      updateState();
      updateProgress();
    }
   }

   void updateState() {
     randomizeVal();
     index++;
     fetchQuestions();
     indices.shuffle();
     _start = 10;
   }

   void updateProgress() {
    if (noOfquestionsAnswered == 10)
      /// emit state win
    if(noOfquestionsAnswered == -10)
      /// emit state lose
    Navigator.pop(context);
   }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void fetchQuestions()  {
    _questionBloc = context.read<QuestionBloc>();
    if(index == 10) {
      _questionBloc.add(QuestionsFetched());
    }
  }
  void randomizeVal(){
    Random random = new Random();
    randomVal = random.nextInt(3);
  }

}