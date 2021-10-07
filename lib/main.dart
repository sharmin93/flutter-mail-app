import 'package:flutter/material.dart';
import 'package:flutter_mail_app/ui/check_mail.dart';
import 'package:flutter_mail_app/ui/create_account_ui.dart';
import 'package:flutter_mail_app/ui/login_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
          theme: ThemeData(accentColor: Colors.orangeAccent,primaryColor: Colors.deepOrangeAccent),
      home: MyHomePage(),
        routes:  <String, WidgetBuilder>{
          '/create_account': (BuildContext context) => CreateAccount(),
          '/login': (BuildContext context) => LogIn(),
          '/check_mail': (BuildContext context) => CheckMail(),
        },
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body: LogIn(),);
  }
}
