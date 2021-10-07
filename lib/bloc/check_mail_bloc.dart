import 'package:flutter_mail_app/bloc/base_bloc.dart';
import 'package:flutter_mail_app/response_model/messages_response_model.dart';

import 'package:rxdart/src/subjects/behavior_subject.dart';
class CheckMailBloc implements BaseBloc{
  final _messageController= BehaviorSubject<MessagesResponseModel>();
  Function(MessagesResponseModel) get changedMessages => _messageController.sink.add;

  Stream<MessagesResponseModel> get messages => _messageController.stream;


  @override
  void dispose() {
    _messageController.close();
  }

}