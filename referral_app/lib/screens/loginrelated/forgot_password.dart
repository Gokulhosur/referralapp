import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/Api_call/api_call_functions.dart';
import 'package:referral_app/screens/loginrelated/emailverify.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailId = TextEditingController();
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
                "Enter your registered email for the verification process, we will send 4 digits code to your email.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: emailId,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          var result = await server.getemailIdOtp(emailId.text);
                          if (result["status"] == "Success") {
                            Get.to(() => Emailverify(
                                  emailId: emailId.text,
                                ));
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
                            // minimumSize: MaterialStateProperty.all(const Size(355, 60)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Generate OTP",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
