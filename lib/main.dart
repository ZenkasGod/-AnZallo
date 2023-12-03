import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doanchuyende/Screen/Login/Hello.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


const bool USE_EMULATOR = true;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (USE_EMULATOR) {
    _connectToFirebaseEmulator();
  }

  runApp(MyApp());
}

Future _connectToFirebaseEmulator() async {
  final fireStorePort = "8080";
  final authPort = "9099";
  final localHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: "$localHost:$fireStorePort",
    sslEnabled: false,
    persistenceEnabled: false);

  await FirebaseAuth.instance.useEmulator("http://$localHost:$authPort");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home:Hello(),
      theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue),

      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
    );
  }
}


