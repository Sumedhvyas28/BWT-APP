class UpdateSpareItems {
  Message? message;

  UpdateSpareItems({this.message});

  UpdateSpareItems.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? status;
  String? message;
  String? collected;

  Message({this.status, this.message, this.collected});

  Message.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    collected = json['collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['collected'] = this.collected;
    return data;
  }
}
