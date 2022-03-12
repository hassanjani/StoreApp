class NotificationModel {
  String id;
  String type;
  String notifiableType;
  String notifiableId;
  Data data;
  Null readAt;
  String createdAt;
  String updatedAt;

  NotificationModel(
      {this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  Letter letter;

  Data({this.letter});

  Data.fromJson(Map<String, dynamic> json) {
    letter =
    json['letter'] != null ? new Letter.fromJson(json['letter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.letter != null) {
      data['letter'] = this.letter.toJson();
    }
    return data;
  }
}

class Letter {
  String message;
  String shopId;
  int orderId;

  Letter({this.message, this.shopId, this.orderId});

  Letter.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    shopId = json['shop_id'] == '1' ? "" : json['shop_id'] == '1';
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['shop_id'] = this.shopId;
    data['order_id'] = this.orderId;
    return data;
  }
}
