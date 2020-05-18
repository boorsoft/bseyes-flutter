import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/question_model.dart';
import '../services/questions_service.dart';
import '../style.dart';
import 'poll-finish.dart';

// Загружаем данные перед выполнением основного класса
class PollsFutureBuilder extends StatefulWidget {
  final Teacher teacher;
  final Subject subject;

  PollsFutureBuilder({this.teacher, this.subject});

  @override
  _PollsFutureBuilderState createState() => _PollsFutureBuilderState();
}

class _PollsFutureBuilderState extends State<PollsFutureBuilder> {
  final QuestionsService questionsService = QuestionsService();

  List<Question> questions;

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
                    subject: widget.subject,
                    teacher: widget.teacher,
                    questions: questions);
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
  int rate;
  List<int> rates = [];

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
      if (qNum < widget.questions.length - 1) {
        qNum++;
        rates.add(rate);
        print(rates);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PollFinish(
                subject: widget.subject,
                teacher: widget.teacher,
                rates: rates)));
      }
      // При каждом следующем вопросе кнопки сбрасываются
      for (int i = 1; i <= 5; i++) buttons[i.toString()] = false;
      choiceMade = false;
    });
  }

  // Метод для определения выбранной кнопки
  void chooseOption(String option) {
    setState(() {
      // Сбрасываем кнопки
      for (int i = 1; i <= 5; i++) buttons[i.toString()] = false;

      buttons[option] = true;
      choiceMade = true;

      if (buttons["1"]) {
        rate = 1;
      } else if (buttons["2"]) {
        rate = 2;
      } else if (buttons["3"]) {
        rate = 3;
      } else if (buttons["4"]) {
        rate = 4;
      } else if (buttons["5"]) {
        rate = 5;
      }
      print(rate);
    });
  }

  // Метод, который возвращает кнопку
  Widget optionButton(String option) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: MaterialButton(
              child: Text(option, style: defaultTextStyleWhiteBold),
              onPressed: () => chooseOption(option),
              minWidth: 40.0,
              color: !buttons[option] ? primaryColor : splashColor,
              splashColor: splashColor,
            )));
  }

  // Метод, который возвращает кнопку 'Дальше'
  Widget nextButton() {
    if (choiceMade) {
      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          child: MaterialButton(
              child: Text('Дальше', style: defaultTextStyleWhiteBold),
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
        appBar: AppBar(
            centerTitle: true, title: Text('Опрос', style: headerTextStyle)),
        body: Container(
            color: primaryColor,
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0))),
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
                    )))));
  }
}
