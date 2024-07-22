import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liveasy/screens/verifyPhoneSccreen.dart';

class MobileNumberScreen extends StatelessWidget {
  MobileNumberScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  verifyPhoneNumber(String number) async {}
  var savedNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Please enter your mobile number",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'You’ll receive a 6 digit code\nto verify next.',
              style: TextStyle(
                  color: Color(0xff6A6C7B), fontSize: 14, fontFamily: 'Roboto'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: formKey,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.88,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                alignment: Alignment.center,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                    savedNumber = number.phoneNumber;
                  },
                  hintText: "Mobile Number",
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    useBottomSheetSafeArea: true,
                  ),
                  ignoreBlank: false,
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: InputBorder.none,
                  onSaved: (PhoneNumber number) {
                    print("Testing");
                    savedNumber = number.phoneNumber!;
                  },
                ),
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
                  formKey.currentState!.save();

                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: savedNumber,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Some error occured!"),
                        ),
                      );
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return VerifyPhoneScreen(
                            phNumber: savedNumber,
                            verificationId: verificationId,
                          );
                        },
                      ));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: const Text(
                  "CONTINUE",
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
