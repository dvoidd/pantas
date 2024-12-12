import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wemos_app/const/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wemos_app/screen/homeScreen1.dart';
import 'package:wemos_app/screen/login.dart';
import 'package:wemos_app/screen/mainScreen.dart';
import 'package:wemos_app/screen/monitorScreen1.dart';
import 'package:wemos_app/screen/table1.dart';
import 'package:wemos_app/services/bindings.dart';
import 'package:wemos_app/services/dataservices.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    runApp(ChangeNotifierProvider(
      create: (context) {
        final provider = SensorDataProvider();
        provider.initializeDataStreams(); // Memulai pengambilan data
        return provider;
      },
      child: GetMaterialApp(
          initialBinding: appBinding(),
          debugShowCheckedModeBanner: false,
          theme: getDefaultTheme(),
          home: LoginPage()),
    ));
    // runApp(MyApp());
  }).catchError((error) {
    print('Error initializing Firebase: $error');
  });
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Code untuk mengambil data dari Firebase dapat ditambahkan di sini
    return Future.value(true);
  });
}
