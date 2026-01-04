import 'package:flutter/material.dart';
import 'package:frontend/app/app.dart';
import 'package:frontend/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(App());
}
