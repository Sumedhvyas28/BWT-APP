import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  Future<http.Response> getGetApiResponse() async {
    //return await _repository.httpGetById('get-shipping-address-by-user-id', userId);
    return await http.get(
        "https://00b6-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance"
            as Uri);
  }

  Future<mainDescription> _getGetApiResponse() async {
    // http.Response response = await http.get(Uri.parse(
    //     'https://00b6-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance'));
    var response = await _getGetApiResponse.getGetApiResponse();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return mainDescription.fromJson(jsonData); // Parse JSON here
    } else {
      throw Exception('Failed to load data'); // Error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<mainDescription>(
        future: _getGetApiResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.message == null ||
              snapshot.data!.message!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final messages =
                snapshot.data!.message!; // Ensure the message list is not null

            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index].content), // Displaying content
                  subtitle: Text(messages[index].sender), // Displaying sender
                );
              },
            );
          }
        },
      ),
    );
  }
}

extension on Future<mainDescription> Function() {
  getGetApiResponse() {}
}

// Make sure your Message and mainDescription classes look like this
class Message {
  final String content;
  final String sender;

  Message({required this.content, required this.sender});

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
    };
  }

  // fromJson method
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      sender: json['sender'],
    );
  }
}

class mainDescription {
  List<Message>? message;

  mainDescription({this.message});

  // From JSON constructor
  mainDescription.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(Message.fromJson(v)); // Correctly parsing each message
      });
    }
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
