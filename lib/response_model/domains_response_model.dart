import 'package:flutter_mail_app/response_model/base_response.dart';

class DomainResponse extends BaseResponse {
  String context;
  String atId;
  String type;
  List<HydraMember> hydraMember;
  int hydraTotalItems;

  DomainResponse(
      {this.context,
        this.atId,
        this.type,
        this.hydraMember,
        this.hydraTotalItems});

  DomainResponse.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    atId = json['@id'];
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
    data['@id'] = this.atId;
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
  String domain;
  bool isActive;
  bool isPrivate;
  String createdAt;
  String updatedAt;

  HydraMember(
      {this.atId,
        this.type,
        this.id,
        this.domain,
        this.isActive,
        this.isPrivate,
        this.createdAt,
        this.updatedAt});

  HydraMember.fromJson(Map<String, dynamic> json) {
    atId = json['@id'];
    type = json['@type'];
    id = json['id'];
    domain = json['domain'];
    isActive = json['isActive'];
    isPrivate = json['isPrivate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.atId;
    data['@type'] = this.type;
    data['id'] = this.id;
    data['domain'] = this.domain;
    data['isActive'] = this.isActive;
    data['isPrivate'] = this.isPrivate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}