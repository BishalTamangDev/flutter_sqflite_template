import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_git/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const LocalDbApp());
}
