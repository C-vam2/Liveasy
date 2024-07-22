import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/screens/mobileNumberScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSelectionScreen extends StatefulWidget {
  const ProfileSelectionScreen({super.key});

  @override
  State<ProfileSelectionScreen> createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  @override
  int groupValue = -1;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              try {
                await auth.signOut().then((value) {
                  prefs.setBool('loggedIn', false);
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MobileNumberScreen(),
                ));
              } catch (e) {
                print("Unable to log out!!");
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please select your profile",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto')),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              height: 90,
              margin: const EdgeInsets.all(20),
              // padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                          },
                        ),
                        const Icon(
                          Icons.warehouse_outlined,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                  title: const Text(
                    "Shipper",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing",
                    style: TextStyle(color: Color(0xff6A6C7B)),
                  ),
                  onTap: () {
                    setState(() {
                      groupValue = 1;
                    });
                  }),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              height: 90,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              // padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: SizedBox(
                  width: 100,
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 2,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                          });
                        },
                      ),
                      const Icon(
                        Icons.emoji_transportation,
                        size: 50,
                      ),
                    ],
                  ),
                ),
                title: const Text(
                  "Transporter",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing",
                  style: TextStyle(color: Color(0xff6A6C7B)),
                ),
                onTap: () {
                  setState(() {
                    groupValue = 2;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
