// ignore_for_file: unused_import
// @dart=2.9
import 'package:cae/Provider/AppConstants.dart';
import 'package:cae/Provider/auth_provider.dart';
import 'package:cae/Screens/intro_screen.dart';
import 'package:cae/Screens/login_screen.dart';
import 'package:cae/StripePayment/payment_screen.dart';
import 'package:cae/Screens/profile_screen.dart';
import 'package:cae/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp() : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConstants()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const ProfileScreen(),
        home: SplashScreen(),
        // home: const SplashScreen(),
        // home: const SplashScreen(),
      ),
    );
  }
}
