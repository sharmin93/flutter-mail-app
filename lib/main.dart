import 'package:flutter/material.dart';
import 'package:flutter_mail_app/response_model/jwt_token_class.dart';
import 'package:flutter_mail_app/ui/check_mail.dart';
import 'package:flutter_mail_app/ui/create_account_ui.dart';
import 'package:flutter_mail_app/ui/login_ui.dart';
import 'package:flutter_mail_app/ui/mail_details_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          '/check_mail_details': (BuildContext context) => MailDetails(),
        },
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int state = 0 ;


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {

      JwtToken.token = prefs.get("jwt");
      print("JWT : ${JwtToken.token}");
      if (JwtToken.token==null || JwtToken.token ==""){
        setState(() {
          state= 1;
        });
      } else {
        setState(() {
          state= 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(body:
       state== 0 ? Container(): state==1?LogIn():CheckMail(),);
  }
}
