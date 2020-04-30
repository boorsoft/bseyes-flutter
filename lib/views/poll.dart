import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/question_model.dart';
import '../services/questions_service.dart';
import '../style.dart';

class PollsFutureBuilder extends StatelessWidget {
  final QuestionsService questionsService = QuestionsService();

  List<Question> questions;
  final Teacher teacher;
  final Subject subject;

  PollsFutureBuilder({this.teacher, this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: questionsService.getQuestions(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
              if (snapshot.hasData) {
                questions = snapshot.data;
                return Poll(
                    subject: subject, teacher: teacher, questions: questions);
              } else if (snapshot.hasError) {
                // Если возникла ошибка
                return Center(
                  child: Text('Не удалось загрузить данные...'),
                );
              } else {
                // Если данные еще не загрузились
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30.0),
                    Center(child: Text('Идёт загрузка данных...'))
                  ],
                );
              }
            }));
  }
}

class Poll extends StatefulWidget {
  final Subject subject;
  final Teacher teacher;
  final List<Question> questions;

  Poll({this.subject, this.teacher, this.questions});

  @override
  PollState createState() => PollState();
}

class PollState extends State<Poll> {
  int qNum = 0;
  Color displayColor = primaryColor;
  bool choiceMade = false;

  Map<String, bool> buttons = {
    "1": false,
    "2": false,
    "3": false,
    "4": false,
    "5": false
  };

  @override
  void initState() {
    super.initState();
  }

  void nextQuestion() {
    setState(() {
      if (choiceMade) {
        if (qNum < widget.questions.length) {
          qNum++;
        } else {}
      }
      buttons["1"] = false;
      buttons["2"] = false;
      buttons["3"] = false;
      buttons["4"] = false;
      buttons["5"] = false;
      choiceMade = false;
    });
  }

  void chooseOption(String option) {
    setState(() {
      buttons["1"] = false;
      buttons["2"] = false;
      buttons["3"] = false;
      buttons["4"] = false;
      buttons["5"] = false;
      buttons[option] = true;
      choiceMade = true;
    });
  }

  Widget optionButton(String option) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: MaterialButton(
              child: Text(option, style: defaultTextStyleBold),
              onPressed: () => chooseOption(option),
              minWidth: 40.0,
              color: !buttons[option] ? primaryColor : splashColor,
              splashColor: splashColor,
            )));
  }

  Widget nextButton() {
    if (choiceMade) {
      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          child: MaterialButton(
              child: Text('Дальше', style: defaultTextStyleBold),
              onPressed: () => nextQuestion(),
              minWidth: 80.0,
              disabledColor: disabledColor,
              color: Theme.of(context).primaryColor,
              splashColor: splashColor));
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('Опрос', style: headerTextStyle)),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(minHeight: 150.0),
                      child: Text(widget.questions[qNum].question,
                          style: defaultTextStyle),
                    ),
                    SizedBox(height: 70.0),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "1 - Полностью согласен, 5 - Абсолютно не согласен",
                          style: defaultTextStyle,
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(height: 10.0),
                    Wrap(
                      children: <Widget>[
                        optionButton("1"),
                        optionButton("2"),
                        optionButton("3"),
                        optionButton("4"),
                        optionButton("5")
                      ],
                    ),
                    SizedBox(height: 50.0),
                    nextButton()
                  ],
                ))));
  }
}
