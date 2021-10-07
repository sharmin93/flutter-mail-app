import 'package:flutter_mail_app/response_model/base_response.dart';

class MessageDetailsModel extends BaseResponse{
  String context;
  String atId;
  String type;
  String id;
  String accountId;
  String msgid;
  User from;
  List<User> to;
  String subject;
  bool seen;
  bool flagged;
  bool isDeleted;
  bool retention;
  String retentionDate;
  String text;
  List<String> html;
  bool hasAttachments;
  int size;
  String downloadUrl;
  String createdAt;
  String updatedAt;

  MessageDetailsModel(
      {this.context,
        this.atId,
        this.type,
        this.id,
        this.accountId,
        this.msgid,
        this.from,
        this.to,
        this.subject,
        this.seen,
        this.flagged,
        this.isDeleted,
        this.retention,
        this.retentionDate,
        this.text,
        this.html,
        this.hasAttachments,
        this.size,
        this.downloadUrl,
        this.createdAt,
        this.updatedAt});

  MessageDetailsModel.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    atId = json['@id'];
    type = json['@type'];
    id = json['id'];
    accountId = json['accountId'];
    msgid = json['msgid'];
    from = json['from'] != null ? new User.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = new List<User>();
      json['to'].forEach((v) {
        to.add(new User.fromJson(v));
      });
    }

    subject = json['subject'];
    seen = json['seen'];
    flagged = json['flagged'];
    isDeleted = json['isDeleted'];

    retention = json['retention'];
    retentionDate = json['retentionDate'];
    text = json['text'];
    html = json['html'].cast<String>();
    hasAttachments = json['hasAttachments'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    data['@id'] = this.atId;
    data['@type'] = this.type;
    data['id'] = this.id;
    data['accountId'] = this.accountId;
    data['msgid'] = this.msgid;
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to.map((v) => v.toJson()).toList();
    }

    data['subject'] = this.subject;
    data['seen'] = this.seen;
    data['flagged'] = this.flagged;
    data['isDeleted'] = this.isDeleted;
    data['retention'] = this.retention;
    data['retentionDate'] = this.retentionDate;
    data['text'] = this.text;
    data['html'] = this.html;
    data['hasAttachments'] = this.hasAttachments;
    data['size'] = this.size;
    data['downloadUrl'] = this.downloadUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class User {
  String address;
  String name;

  User({this.address, this.name});

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    return data;
  }
}
