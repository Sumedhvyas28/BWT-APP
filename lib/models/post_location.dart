class postLocation {
  Message? message;

  postLocation({this.message});

  postLocation.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['distance'] = distance;
    data['message'] = message;
    return data;
  }
}
