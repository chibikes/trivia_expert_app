import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // final database = openDatabase(join(await getDatabasesPath(), 'trivia_ex.datbase'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //         'CREATE TABLE questions(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
  //     );
  //   },
  //   version: 1,
  // );
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  runApp(App(authenticationRepository: AuthenticationRepository()));
}
