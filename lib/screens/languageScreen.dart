import 'package:flutter/material.dart';

import 'package:liveasy/clippers/waveclippers.dart';
import 'package:liveasy/screens/mobileNumberScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.photo_outlined,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please select your language",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'You can change the language\nat any time.',
                  style: TextStyle(
                      color: Color(0xff6A6C7B),
                      fontSize: 14,
                      fontFamily: 'Roboto'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 25),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    hint: Text('Select Language'),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                          value: 'English', child: Text('English')),
                      DropdownMenuItem(value: 'Others', child: Text('Others')),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      Navigator.of(context)
                        ..pushReplacement(MaterialPageRoute(
                            builder: (ctx) => MobileNumberScreen()));
                      prefs.setBool('firstTime', true);
                    },
                    child: const Text(
                      "NEXT",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Color(0xff93D2F3).withOpacity(0.5),
                height: 120, // Adjust as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
