import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:liveasy/screens/profileSelectionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class VerifyPhoneScreen extends StatefulWidget {
  String phNumber;
  String verificationId;
  VerifyPhoneScreen(
      {super.key, required this.phNumber, required this.verificationId});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  var smsCode;

  TapGestureRecognizer? _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _requestNewCode;
  }

  @override
  void dispose() {
    _tapGestureRecognizer?.dispose();
    super.dispose();
  }

  void _requestNewCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Some error occured!"),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("OTP sent")));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Verify Phone",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Code is sent to ${widget.phNumber}',
              style: const TextStyle(
                  color: Color(0xff6A6C7B), fontSize: 14, fontFamily: 'Roboto'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              child: OtpTextField(
                numberOfFields: 6,
                keyboardType: TextInputType.numberWithOptions(),
                onCodeChanged: (value) {
                  print(value);
                },
                onSubmit: (value) {
                  setState(() {
                    smsCode = value;
                  });
                },
                showFieldAsBox: true,
                fillColor: Color(0xff93D2F3),
                filled: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Didn’t receive the code? ',
                    style: TextStyle(
                      color: Color(0xff6A6C7B),
                    ),
                  ),
                  TextSpan(
                    text: 'Request Again',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    recognizer: _tapGestureRecognizer,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.88,
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await auth
                        .signInWithCredential(credential)
                        .then((value) => prefs.setBool('loggedIn', true));
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ProfileSelectionScreen(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Invalid OTP."),
                      ),
                    );
                  }
                },
                child: const Text(
                  "VERIFY AND CONTINUE",
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
    );
  }
}
