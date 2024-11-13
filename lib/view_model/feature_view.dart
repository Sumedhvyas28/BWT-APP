import 'package:flutter/material.dart';
import 'package:flutter_application_1/repository/auth_repo.dart';

class FeatureView with ChangeNotifier {
  final _myrepo = AuthRepository();
}
