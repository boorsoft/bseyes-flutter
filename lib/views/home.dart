import 'package:bseyes_flutter/style.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                height: 400.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      'Авторизация',
                      style: headingTextStyle,
                    )),
                    SizedBox(height: 20.0),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Логин',
                            style: defaultTextStyleBold,
                          ),
                          SizedBox(height: 20.0),
                          Container(
                              child: TextField(
                                  decoration: InputDecoration(
                                      labelText: 'Введите логин...',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              style: BorderStyle.solid,
                                              width: 3.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black87,
                                              style: BorderStyle.solid,
                                              width: 3.0)))))
                        ]),
                    SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Пароль',
                          style: defaultTextStyleBold,
                        ),
                        SizedBox(height: 20.0),
                        Container(
                            child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Введите пароль...',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            style: BorderStyle.solid,
                                            width: 3.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black87,
                                            style: BorderStyle.solid,
                                            width: 3.0)))))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15.0),
                      child: RaisedButton(
                        onPressed: () => print('Button pressed!'),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text('ВОЙТИ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 3.5)),
                      ),
                    )
                  ],
                ))));
  }
}
