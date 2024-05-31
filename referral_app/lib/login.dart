// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:referral_app/screens/loginrelated/signup.dart';

import 'Api_call/api_call_functions.dart';
import 'controllers/getcontroller.dart';
import 'homepage.dart';
import 'screens/loginrelated/forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobleVar controller = Get.put(GlobleVar());
  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();

  bool showpassword = false;

  final _form = GlobalKey<FormState>();
  bool isValid = false;
  bool ispermitioneGranted = false;

  @override
  void initState() {
    super.initState();
    gettoken();
    initcall();
  }

  gettoken() async {
    // var temp =
    await server.gettoken();
  }

  void saveForm() {
    setState(() {
      isValid = _form.currentState!.validate();
    });
  }

  initcall() async {
    print("data");

    var status = await Permission.storage.status;
    if (status.isGranted) {
      ispermitioneGranted = true;
      // We didn't ask for permission yet or the permission has been denied before, but not permanently.
    } else if (status.isDenied) {
      print("hello");
      // ignore: unused_local_variable
      Map<Permission, PermissionStatus> status =
          await [Permission.storage].request();
    }
    var camerastatus = await Permission.camera.status;
    if (camerastatus.isGranted) {
      ispermitioneGranted = true;
      // We didn't ask for permission yet or the permission has been denied before, but not permanently.
    } else if (camerastatus.isDenied) {
      print("hello");
      // ignore: unused_local_variable
      Map<Permission, PermissionStatus> status =
          await [Permission.camera].request();
    }
    // if (await Permission.location.serviceStatus.isEnabled) {
    //   //Permissio enabled
    //   ispermitioneGranted = true;
    // } else {
    //   ispermitioneGranted = false;
    //   // ignore: unused_local_variable
    //   Map<Permission, PermissionStatus> status = await [
    //     Permission.location,
    //   ].request();
    // }

    // if (await Permission.location.isPermanentlyDenied) {
    //   //openAppSettings();
    //   //Permissio enabled
    // } else {
    //   //PErmision disabled
    // }

// You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
    //   // The OS restricts access, for example because of parental controls.
    // }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Settings"),
      onPressed: () {
        openAppSettings();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Flooff: Required Location Permission"),
      content: const Text("Allow location permission to proceed in settings."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // var height = size.height;
    //var width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(15, 50, 160, 1),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                "assets/Logo.png",
                width: 250,
              ),
            ),
            // Spacer(),
            Expanded(
              child: Container(
                //height: height / 1.30,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Login ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: emailid,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == "") {
                                  return "Email Id is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  label: Text("Email"),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: TextFormField(
                              controller: password,
                              obscuringCharacter: '*',
                              obscureText: !showpassword,
                              validator: (value) {
                                if (value == "") {
                                  return "Password is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showpassword = !showpassword;
                                      });
                                    },
                                    icon: showpassword
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  label: const Text("Password"),
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    15, 50, 160, 1))),
                                    onPressed: () async {
                                      saveForm();
                                      if (isValid) {
                                        var result = await server.login(
                                            emailid.text, password.text);
                                        if (result["status"] == "Success") {
                                          Get.off(() => const Homepage(
                                                pageno: 0,
                                              ));
                                        } else {
                                          var snackBar = const SnackBar(
                                            elevation: 30,
                                            shape: StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(50),
                                            content: Text("Login Failed.."),
                                          );

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text("Login",
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgotPassword());
                                },
                                child: const Text("Forgot Password?"),
                              )
                            ],
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.only(top: 10),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Divider(
                          //           thickness: 2,
                          //         ),
                          //       ),
                          //       Text("    or    "),
                          //       Expanded(
                          //         child: Divider(
                          //           thickness: 2,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 30, bottom: 20),
                          //   child: Container(
                          //     decoration: BoxDecoration(border: Border.all()),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Image.asset("assets/Google Icon.png"),
                          //         const Padding(
                          //           padding: EdgeInsets.all(15),
                          //           child: Text("Login with Google"),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const Signup());
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
