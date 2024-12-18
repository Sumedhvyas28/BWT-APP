import 'dart:convert';
import 'dart:io';

class SymptomData {
  String symptom;
  String solution;
  File? image;

  SymptomData({
    required this.symptom,
    required this.solution,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'symptom_code': symptom,
      'resolution': solution,
      'image': image != null ? base64Encode(image!.readAsBytesSync()) : null,
    };
  }
}
