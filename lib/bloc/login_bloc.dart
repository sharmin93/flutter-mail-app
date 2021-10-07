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
  final _passwordController = BehaviorSubject<PasswordModel>();
  final _emailController = BehaviorSubject<String>();

  //sink data//
  Function(LogInResponse) get changedField => _logInController.sink.add;

  Function(PasswordModel) get changedPassword => _passwordController.sink.add;

  Function(String) get changedEmail => _emailController.sink.add;

  Stream<LogInResponse> get logInButton => _logInController.stream;

  Stream<PasswordModel> get password => _passwordController.stream;
  Stream<String> get email => _emailController.stream;


  signInButton() async {
    String emailValue = _emailController.stream.value.toLowerCase();
    final prefs = await SharedPreferences.getInstance();

    String passValue = _passwordController.stream.value.password;
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
    _logInController.close();
    _passwordController.close();
   _emailController.close();
}



}