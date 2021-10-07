import 'package:flutter_mail_app/response_model/logIn_response_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

import 'base_bloc.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
class LogInBloc implements BaseBloc {
  //controller//
  final _logInController = BehaviorSubject<LogInResponse>();
  final _passwordController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();

  //sink data//
  Function(LogInResponse) get changedField => _logInController.sink.add;

  Function(String) get changedPassword => _passwordController.sink.add;

  Function(String) get changedEmail => _emailController.sink.add;

  Stream<LogInResponse> get logInButton => _logInController.stream;

  Stream<String> get password => _passwordController.stream;
  Stream<String> get email => _emailController.stream;


  signInButton() async {
    String emailValue = _emailController.stream.value.toLowerCase();
//     bool emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+(\.[a-zA-Z]+)*\.[a-zA-Z]+[a-zA-Z]+$").hasMatch(emailValue);
// //    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailValue);
//     if(emailValid==false){
//       _logInController.sink.addError('Email formation is not correct');
//       return  null;
//     }
    String passValue = _passwordController.stream.value;
    var _error;
    var apiCall=APICall();
    var logInData={
      "address": emailValue.toLowerCase(),
      "password": passValue
    };
    LogInResponse  res= await apiCall.logIn(logInData);
    print('logInRes${res}');
    if(res.success){
      print('logIn SuccessFull ${res.token}');


    }else{
      _error=res.errorMessage;
      print('error ${res.errorTitle}');
      print('error mesage${res.errorMessage}');
      _logInController.addError(res.errorMessage);

    }

    return res;
  }

  @override
  void dispose() {
    _logInController.close();
    _passwordController.close();
   _emailController.close();
}}