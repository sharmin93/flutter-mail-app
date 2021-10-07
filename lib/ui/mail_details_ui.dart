import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mail_app/bloc/message_details_bloc.dart';
import 'package:flutter_mail_app/response_model/message_details_response_model.dart';
import 'package:flutter_mail_app/service_request/service_call.dart';

class MailDetails extends StatelessWidget {
  final messageDetailsBloc = MessageDetailsBloc();

  @override
  Widget build(BuildContext context) {
  var  receivedData = ModalRoute.of(context).settings.arguments;
  APICall().getMessageDetails(receivedData).then((value) {
    messageDetailsBloc.changedMessagesDetails.call(value);
  });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mail details'),
      ),
      body: SingleChildScrollView(child: StreamBuilder<MessageDetailsModel>(
        stream: messageDetailsBloc.messagesDetails,
        builder: (context, snapshot) {
          return snapshot.hasData? Column(children: [
            Text('Form ${snapshot.data.from.name}'),
            SizedBox(height: 10,),
            Text('Subject: ${snapshot.data.subject}'),
            SizedBox(height: 10,),
            Text('${snapshot.data.text}'),
          ],):Center(child: CircularProgressIndicator());
        }
      )),
    );
  }
}
