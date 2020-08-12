import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizzer",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  int totalscore=0;

  bool isLastQuestionsCalled = false;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
          size: 40,
        ));

        totalscore++;

        isLastQuestionsCalled = quizBrain.isLastQuestionsCalled();

      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
          size: 40,
        ));

        isLastQuestionsCalled = quizBrain.isLastQuestionsCalled();

      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !isLastQuestionsCalled?
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ):Text(""),
            !isLastQuestionsCalled?Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        //The user picked true.
                        checkAnswer(true);
                      },
                    ),

                    FlatButton(
                      color: Colors.red,
                      child: Text(
                        'False',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //The user picked false.
                        checkAnswer(false);
                      },
                    ),

                  ],
                ),

            ):Text(""),


            isLastQuestionsCalled? Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Take Quiz Again',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {

                    setState(() {

                      isLastQuestionsCalled=false;

                      scoreKeeper.clear();

                      totalscore = 0;

                      quizBrain.reset();


                    });


                  },

              ),
            ):Text(""),

            isLastQuestionsCalled?Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                    "Total Score : "+totalscore.toString()+" / "+quizBrain.getQuestionsnumber().toString(),
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
              ),
            ):Text(""),
            Wrap(


                children: scoreKeeper,

            )
          ],
        ),
      ),
    );
  }
}