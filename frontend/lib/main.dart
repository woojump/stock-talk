import 'package:flutter/material.dart';
import 'package:stock_talk/app/app.dart';
import 'package:stock_talk/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(App());
}
