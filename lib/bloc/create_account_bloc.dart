import 'package:flutter_mail_app/bloc/base_bloc.dart';
import 'package:flutter_mail_app/response_model/create_account_response_model.dart';
import 'package:flutter_mail_app/response_model/logIn_response_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
class CreateAccountBloc implements BaseBloc{
  //controller//
  final _accountCreateController = BehaviorSubject<CreateAccountResponse>();
  final _passwordController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();


  Function(CreateAccountResponse) get changedAccountCreate => _accountCreateController.sink.add;

  Function(String) get changedPassword => _passwordController.sink.add;

  Function(String) get changedEmail => _emailController.sink.add;

  Stream<CreateAccountResponse> get accountCreate => _accountCreateController.stream;

  Stream<String> get password => _passwordController.stream;
  Stream<String> get email => _emailController.stream;


  createAccountButton() async {
    String emailValue = _emailController.stream.value.toLowerCase();
//     bool emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+(\.[a-zA-Z]+)*\.[a-zA-Z]+[a-zA-Z]+$").hasMatch(emailValue);
// //    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailValue);
//     if(emailValid==false){
//       _logInController.sink.addError('Email formation is not correct');
//       return  null;
//     }
    String passValue = _passwordController.stream.value;
    var domainResponse=await APICall().getDomain();
    if(!emailValue.endsWith(domainResponse.hydraMember[0].domain)){
      _accountCreateController.addError("Domain must be ${domainResponse.hydraMember[0].domain}");
      return null;
    }
    var apiCall=APICall();
    var createAccountData={
      "address": emailValue.toLowerCase(),
      "password": passValue
    };
    CreateAccountResponse   res= await apiCall.createAccount(createAccountData);
    print('logInRes${res}');
    if(res.success){
      print('logIn SuccessFull ${res.success}');
    }else{
      print('error ${res.errorTitle}');
      print('error mesage${res.errorMessage}');
      _accountCreateController.addError(res.errorMessage);
    }
    return res;
  }

  @override
  void dispose() {
    _accountCreateController.close();
    _passwordController.close();
    _emailController.close();
  }

}