class UserData {
  Message? message;

  UserData({this.message});

  UserData.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Message({this.status, this.message, this.user});

  Message.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? fullName;
  String? apiKey;
  String? apiSecret;

  User({this.email, this.fullName, this.apiKey, this.apiSecret});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    apiKey = json['api_key'];
    apiSecret = json['api_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['api_key'] = this.apiKey;
    data['api_secret'] = this.apiSecret;
    return data;
  }
}
