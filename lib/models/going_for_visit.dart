class GoingForVisit {
  Message? message;

  GoingForVisit({this.message});

  GoingForVisit.fromJson(Map<String, dynamic> json) {
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
  String? visitStart;

  Message({this.status, this.message, this.visitStart});

  Message.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    visitStart = json['visit_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['visit_start'] = this.visitStart;
    return data;
  }
}
