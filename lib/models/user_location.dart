class UserLocation {
  Message? message;

  UserLocation({this.message});

  UserLocation.fromJson(Map<String, dynamic> json) {
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
  String? distance;
  bool? message;

  Message({this.status, this.distance, this.message});

  Message.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distance = json['distance'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['distance'] = this.distance;
    data['message'] = this.message;
    return data;
  }
}
