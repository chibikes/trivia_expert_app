import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'app.dart';
import 'main_models/questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FileStorage.instance;
  EquatableConfig.stringify = kDebugMode;
  initIndex();
  runApp(App(authenticationRepository: AuthenticationRepository()));
  // HttpOverrides.global = new MyHttpOverrides();
}
void initIndex() async {
  await FileStorage.instance.then((value) => value.setInt('index', 0));
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }