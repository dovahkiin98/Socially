import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/data/repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Application to `edgeToEdge`
  // This has no effect in Android 15 onwards, nor before Android 10
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Set System Bars to Transparent color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: false,
  // );

  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(
    MultiRepositoryProvider(
      providers: [
        // Add the Repository as a global provider
        RepositoryProvider(
            create: (_) => Repository(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance,
                )),
      ],
      child: const MyApp(),
    ),
  );
}
