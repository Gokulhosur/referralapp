import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:referral_app/Api_call/api_call_functions.dart';

import 'reset_password.dart';

class Emailverify extends StatefulWidget {
  final emailId;
  const Emailverify({super.key, required this.emailId});

  @override
  // ignore: library_private_types_in_public_api
  _EmailverifyState createState() => _EmailverifyState();
}

class _EmailverifyState extends State<Emailverify> {
  var otp;

  final defaultPinTheme = PinTheme(
      width: 67,
      height: 70,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Forgot Password")),
        body: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 25, bottom: 30, left: 20, right: 20),
              child: Text(
                "Enter the 4 digit code that you received on your registered email.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 20),
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!
                        .copyWith(border: Border.all())),
                onCompleted: (pin) {
                  debugPrint(pin);
                  setState(() {
                    otp = pin;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          var result = await server.verifyemailIdOtp(
                              widget.emailId, otp);
                          if (result["status"] == "Success") {
                            Get.to(
                                () => ResetPassword(emailId: widget.emailId));
                          } else {
                            var snackBar = SnackBar(
                              elevation: 30,
                              shape: const StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(50),
                              content: Text(result["data"]),
                            );
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 7, 0, 102)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Submit Code",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                text: const TextSpan(
                  text: "Code not received? ",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Resend in 00:34",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
