import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api_call/api_call_functions.dart';
import '../../login.dart';

class ResetPassword extends StatefulWidget {
  final emailId;
  const ResetPassword({super.key, required this.emailId});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool enterpassword = false;
  bool reenterpassword = false;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool isValid = false;

  void saveForm() {
    setState(() {
      isValid = _form.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset your Password")),
      body: Form(
        key: _form,
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.only(top: 25, bottom: 30, left: 20, right: 20),
              child: Text(
                "Set the new password for your account so you can login and access all the features",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: password,
                obscureText: !enterpassword,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == "") {
                    return "PassWord is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Enter New Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          enterpassword = !enterpassword;
                        });
                      },
                      icon: Icon(enterpassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: confirmpassword,
                obscureText: !reenterpassword,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == "") {
                    return "ConfirmPassword is required";
                  }
                  if (value != "" && password.text != value) {
                    return "Password and ConfirmPassword does not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          reenterpassword = !reenterpassword;
                        });
                      },
                      icon: Icon(reenterpassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: 'Re-enter New Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          saveForm();
                          if (isValid) {
                            var result = await server.changepassword(
                                widget.emailId, password.text);
                            if (result["status"] == "Success") {
                              Get.offAll(() => const Login());
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
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Update Password",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
