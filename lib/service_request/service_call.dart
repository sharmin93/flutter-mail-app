import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mail_app/constant_url.dart';
import 'package:flutter_mail_app/network_utils/http_client.dart';
import 'package:flutter_mail_app/response_model/create_account_response_model.dart';
import 'package:flutter_mail_app/response_model/domains_response_model.dart';
import 'package:flutter_mail_app/response_model/jwt_token_class.dart';
import 'package:flutter_mail_app/response_model/logIn_response_model.dart';
import 'package:flutter_mail_app/response_model/message_details_response_model.dart';
import 'package:flutter_mail_app/response_model/messages_response_model.dart';
import 'package:flutter_mail_app/ui/login_ui.dart';

class APICall {
 Future<DomainResponse> getDomain(){
   var completer=Completer<DomainResponse>();
   HttpClient.get(domainsUrl).then((response) {
     if (response.statusCode>= 200 && response.statusCode<=299) {
       var domainResponse = DomainResponse.fromJson(json.decode(response.data));
       domainResponse.statusCode = response.statusCode;
       domainResponse.success=true;
       completer.complete(domainResponse);
     } else{
       var domainResponse=DomainResponse();
       domainResponse.statusCode = response.statusCode;
       domainResponse.success=false;

       domainResponse.errorMessage='Something went wrong';
       completer.complete(domainResponse);
     }
   });
   return completer.future;
  }

 Future<CreateAccountResponse> createAccount(dynamic body){
   var completer=Completer<CreateAccountResponse>();
   HttpClient.post(createAccountUrl,body).then((response) {
     if (response.statusCode>= 200 && response.statusCode<=299) {
       var createAccountResponse = CreateAccountResponse.fromJson(json.decode(response.data));
       createAccountResponse.statusCode = response.statusCode;
       createAccountResponse.success=true;
       completer.complete(createAccountResponse);
     } else{
       var createAccountResponse=CreateAccountResponse();
       createAccountResponse.statusCode = response.statusCode;
       createAccountResponse.success=false;
       createAccountResponse.errorTitle=response.data['hydra:title'];
       createAccountResponse.errorMessage=response.data['hydra:description'];
       completer.complete(createAccountResponse);
     }
   });
   return completer.future;
  }

 Future<LogInResponse> logIn(dynamic body){
   var completer=Completer<LogInResponse>();
   HttpClient.post(logInUrl,body).then((response) {
     if (response.statusCode>= 200 && response.statusCode<=299) {
       var loginResponse = LogInResponse.fromJson(response.data);
       print('loginResponse ${loginResponse}');
       loginResponse.statusCode = response.statusCode;
       loginResponse.success=true;
       completer.complete(loginResponse);
     } else{
       var loginResponse=LogInResponse();
       loginResponse.statusCode = response.statusCode;
       loginResponse.success=false;
       loginResponse.errorTitle='An error occurred.';
       loginResponse.errorMessage=response.data['message'];
       completer.complete(loginResponse);
     }
   });
   return completer.future;
  }

  Future<MessagesResponseModel> getMessages(){
   var completer=Completer<MessagesResponseModel>();
   HttpClient.get(messagesUrl, token : JwtToken.token).then((response) {
     if (response.statusCode>= 200 && response.statusCode<=299) {
       var messageResponse = MessagesResponseModel.fromJson(json.decode(response.data));
       messageResponse.statusCode = response.statusCode;
       messageResponse.success=true;
       completer.complete(messageResponse);
     } else{
       var messageResponse=MessagesResponseModel();
       messageResponse.statusCode = response.statusCode;
       messageResponse.success=false;
       messageResponse.errorTitle='An error occurred.';
       messageResponse.errorMessage=response.data['message'];
       completer.complete(messageResponse);
     }
   });
   return completer.future;
  }
  Future<MessageDetailsModel> getMessageDetails(String id){
   var completer=Completer<MessageDetailsModel>();
   HttpClient.get("$messagesUrl/$id", token : JwtToken.token).then((response) {
     if (response.statusCode>= 200 && response.statusCode<=299) {
       var messageDetails = MessageDetailsModel.fromJson(json.decode(response.data));
       messageDetails.statusCode = response.statusCode;
       messageDetails.success=true;
       completer.complete(messageDetails);
     } else{
       var messageResponse=MessageDetailsModel();
       messageResponse.statusCode = response.statusCode;
       messageResponse.success=false;
       messageResponse.errorTitle='An error occurred.';
       messageResponse.errorMessage=response.data['message'];
       completer.complete(messageResponse);
     }
   });
   return completer.future;
  }

}