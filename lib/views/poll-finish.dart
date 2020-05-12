import 'package:flutter/material.dart';

import 'package:bseyes_flutter/style.dart';

class PollFinish extends StatefulWidget {
  @override
  PollFinishState createState() => PollFinishState();
}

class PollFinishState extends State<PollFinish> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Комментарий')),
        body: Container(
            color: primaryColor,
            child: Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    child: Container(
                        color: Colors.white,
                        child: ListView(
                          padding: EdgeInsets.all(7.0),
                          children: <Widget>[
                            Container(
                                child: TextField(
                              controller: commentController,
                              maxLength: TextField.noMaxLength,
                              maxLines: 10,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5.0),
                                labelText: 'Напишите комментарий',
                              ),
                            )),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15.0),
                              child: RaisedButton(
                                onPressed: () => {},
                                splashColor: splashColor,
                                padding: EdgeInsets.all(10.0),
                                color: Colors.black87,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Text('ОТПРАВИТЬ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        letterSpacing: 3.5)),
                              ),
                            )
                          ],
                        ))))));
  }
}
