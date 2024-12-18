import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class UploadApiImage {
  Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
    Uri url = Uri.parse(
        "https://124a-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.attachment");
    var request = http.MultipartRequest("POST", url);
    var myFile = http.MultipartFile(
      "file",
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: fileName,
    );
    request.files.add(myFile);
    final respones = await request.send();
    if (respones.statusCode == 201) {
      var data = await respones.stream.bytesToString();
      print('loldldaldqodfq ');
      return jsonDecode(data);
    } else {
      print('nullffkfk');
      return null;
    }
  }
}
