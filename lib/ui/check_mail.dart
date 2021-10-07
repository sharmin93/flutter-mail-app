import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mail_app/bloc/check_mail_bloc.dart';
import 'package:flutter_mail_app/response_model/messages_response_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

class CheckMail extends StatelessWidget{
  final messagesBloc=CheckMailBloc();
  var apiCall=APICall();
  void refresh(){
    apiCall.getMessages().then((response){
      if(response.success){
        messagesBloc.changedMessages.call(response);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(appBar: AppBar(title: Row(
      children: [
        Text('Inbox',),
        SizedBox(width: 10,),
        InkWell(onTap:(){
          refresh();
        },child: Text('Refresh',)),
      ],
    ),centerTitle: true,),
      body: StreamBuilder<MessagesResponseModel>(
        stream: messagesBloc.messages,
        builder: (context, snapshot) {
          return snapshot.hasData?
            Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView.builder(shrinkWrap: true,
                itemCount: snapshot.data.hydraMember.length,
                itemBuilder: (context,index){
              return InkWell(onTap: (){
                Navigator.pushNamed(context, '/check_mail_details',arguments: snapshot.data.hydraMember[index].id);
              },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8.0),
                      ),
                    height: MediaQuery.of(context).size.height*.09,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${snapshot.data.hydraMember[index].from.name}',style: TextStyle(fontSize: 16),),
                        SizedBox(width: 15,),
                        Text('${snapshot.data.hydraMember[index].subject}',style: TextStyle(fontSize: 16),),
                    ],),
                  ),
                ),
              );
            }),
          ):Container(child: Center(child: CircularProgressIndicator()),);
        }
      ),
    );
  }

}