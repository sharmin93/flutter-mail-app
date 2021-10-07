import 'package:flutter_mail_app/bloc/base_bloc.dart';
import 'package:flutter_mail_app/response_model/message_details_response_model.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
class MessageDetailsBloc implements BaseBloc{
  final _messageDetailsController=BehaviorSubject<MessageDetailsModel>();
  Function(MessageDetailsModel) get changedMessagesDetails => _messageDetailsController.sink.add;
  Stream<MessageDetailsModel> get messagesDetails => _messageDetailsController.stream;

  @override
  void dispose() {
    _messageDetailsController.close();
  }

}
