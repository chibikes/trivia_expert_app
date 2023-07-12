import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeGoogleAds();
  await FileStorage.instance;
  EquatableConfig.stringify = kDebugMode;
  runApp(App(
    firebaseUserRepository: FirebaseUserRepository(),
    authenticationRepository: AuthenticationRepository(),
    gameRepository: GameRepository(),
  ));
  HttpOverrides.global = new MyHttpOverrides();
}

Future<InitializationStatus> initializeGoogleAds() {
  return MobileAds.instance.initialize();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
