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
  final _showPassword = BehaviorSubject<bool>();

  Function(CreateAccountResponse) get changedAccountCreate => _accountCreateController.sink.add;
  Function(bool) get changedShow => _showPassword.sink.add;
  Stream<bool> get show => _showPassword.stream;
  Function(String) get changedPassword => _passwordController.sink.add;

  Function(String) get changedEmail => _emailController.sink.add;

  Stream<CreateAccountResponse> get accountCreate => _accountCreateController.stream;

  Stream<String> get password => _passwordController.stream;
  Stream<String> get email => _emailController.stream;


  createAccountButton() async {
    String emailValue = _emailController.stream.value.toLowerCase();
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

    if(res.success){
      print('sign up SuccessFull ${res.success}');
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
    _showPassword.close();
  }

}