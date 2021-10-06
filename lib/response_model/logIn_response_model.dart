import 'package:flutter_mail_app/response_model/base_response.dart';

class LogInResponse extends BaseResponse {
  String token;
  String id;

  LogInResponse({this.token, this.id});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    return data;
  }
}