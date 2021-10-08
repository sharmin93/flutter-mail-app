import 'package:flutter_mail_app/response_model/jwt_token_class.dart';
import 'package:flutter_mail_app/response_model/logIn_response_model.dart';
import 'package:flutter_mail_app/response_model/password_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

import 'base_bloc.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LogInBloc implements BaseBloc {
  //controller//
  final _logInController = BehaviorSubject<LogInResponse>();
  final _passwordController = BehaviorSubject<String>();
  final _showPassword = BehaviorSubject<bool>();
  final _emailController = BehaviorSubject<String>();

  //sink data//
  Function(LogInResponse) get changedField => _logInController.sink.add;

  Function(String) get changedPassword => _passwordController.sink.add;
  Function(bool) get changedShow => _showPassword.sink.add;

  Function(String) get changedEmail => _emailController.sink.add;

  Stream<LogInResponse> get logInButton => _logInController.stream;

  Stream<String> get password => _passwordController.stream;
  Stream<String> get email => _emailController.stream;
  Stream<bool> get show => _showPassword.stream;


  signInButton() async {
    String emailValue = _emailController.stream.value.toLowerCase();
    final prefs = await SharedPreferences.getInstance();

    String passValue = _passwordController.stream.value;
    print(passValue);
    var apiCall=APICall();
    var logInData={
      "address": emailValue.toLowerCase(),
      "password": passValue
    };
    LogInResponse  res= await apiCall.logIn(logInData);
    print('logInRes${res}');
    if(res.success){
      print('logIn SuccessFull ${res.token}');
      await prefs.setString("jwt", res.token);
      JwtToken.token = res.token;
    }else{
      print('error ${res.errorTitle}');
      print('error message ${res.errorMessage}');
      _logInController.addError(res.errorMessage);
    }
    return res;
  }

  @override
  void dispose() {
    _showPassword.close();
    _logInController.close();
    _passwordController.close();
   _emailController.close();
}



}