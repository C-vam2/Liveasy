import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/screens/languageScreen.dart';
import 'package:liveasy/screens/mobileNumberScreen.dart';
import 'package:liveasy/screens/profileSelectionScreen.dart';
import 'package:liveasy/screens/verifyPhoneSccreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(prefs.getBool('loggedIn'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff2E3B62)),
        useMaterial3: true,
        primaryColor: Color(0xff2E3B62),
      ),
      home: (prefs.getBool('loggedIn') == null)
          ? MobileNumberScreen()
          : prefs.getBool('loggedIn')!
              ? ProfileSelectionScreen()
              : (prefs.getBool('firstTime') == null ||
                      prefs.getBool('firstTime') == false)
                  ? LanguageScreen()
                  : MobileNumberScreen(),
    );
  }
}
