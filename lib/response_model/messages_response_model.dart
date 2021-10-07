import 'package:flutter_mail_app/response_model/base_response.dart';

class MessagesResponseModel extends BaseResponse {
  String context;
  String id;
  String type;
  List<HydraMember> hydraMember;
  int hydraTotalItems;

  MessagesResponseModel(
      {this.context,
        this.id,
        this.type,
        this.hydraMember,
        this.hydraTotalItems});

  MessagesResponseModel.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    id = json['@id'];
    type = json['@type'];
    if (json['hydra:member'] != null) {
      hydraMember = new List<HydraMember>();
      json['hydra:member'].forEach((v) {
        hydraMember.add(new HydraMember.fromJson(v));
      });
    }
    hydraTotalItems = json['hydra:totalItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    data['@id'] = this.id;
    data['@type'] = this.type;
    if (this.hydraMember != null) {
      data['hydra:member'] = this.hydraMember.map((v) => v.toJson()).toList();
    }
    data['hydra:totalItems'] = this.hydraTotalItems;
    return data;
  }
}

class HydraMember {
  String atId;
  String type;
  String id;
  String accountId;
  String msgid;
  User from;
  List<User> to;
  String subject;
  String intro;
  bool seen;
  bool isDeleted;
  bool hasAttachments;
  int size;
  String downloadUrl;
  String createdAt;
  String updatedAt;

  HydraMember(
      {this.atId,
        this.type,
        this.id,
        this.accountId,
        this.msgid,
        this.from,
        this.to,
        this.subject,
        this.intro,
        this.seen,
        this.isDeleted,
        this.hasAttachments,
        this.size,
        this.downloadUrl,
        this.createdAt,
        this.updatedAt});

  HydraMember.fromJson(Map<String, dynamic> json) {
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
    intro = json['intro'];
    seen = json['seen'];
    isDeleted = json['isDeleted'];
    hasAttachments = json['hasAttachments'];
    size = json['size'];
    downloadUrl = json['downloadUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
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
    data['intro'] = this.intro;
    data['seen'] = this.seen;
    data['isDeleted'] = this.isDeleted;
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
