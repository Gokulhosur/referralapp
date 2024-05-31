import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/profile/profile.dart';

import '../../Api_call/api_call_functions.dart';
import '../../controllers/getcontroller.dart';
//import 'package:get/get.dart';

class BankSetup extends StatefulWidget {
  const BankSetup({super.key});

  @override
  State<BankSetup> createState() => _BankSetupState();
}

class _BankSetupState extends State<BankSetup> {
  GlobleVar controller = Get.find();

  TextEditingController bankname = TextEditingController();
  TextEditingController accountholdername = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController ifsccode = TextEditingController();
  @override
  void initState() {
    super.initState();
    bankname.text = controller.logindetails["bankName"] ?? "";
    accountholdername.text = controller.logindetails["accountHolderName"] ?? "";
    accountnumber.text = controller.logindetails["accountNumber"] ?? "";
    ifsccode.text = controller.logindetails["ifscCode"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Setup Bank Account"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
                child: Text(
                  "Please enter your bank details to setup your account to receive and earn commission",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                child: TextFormField(
                  controller: bankname,
                  decoration: InputDecoration(
                    labelText: 'Bank name',
                    // alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                child: TextFormField(
                  controller: accountholdername,
                  decoration: InputDecoration(
                    labelText: 'Account Holder Name',
                    // alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                child: TextFormField(
                  controller: accountnumber,
                  decoration: InputDecoration(
                    labelText: 'Account Number ',
                    // alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 12, right: 12),
                child: TextFormField(
                  controller: ifsccode,
                  decoration: InputDecoration(
                    labelText: 'IFSC Code',
                    // alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var result = await server.updatebankdetails(
                      controller.logindetails["firstName"],
                      controller.logindetails["lastName"],
                      controller.logindetails["emailId"],
                      controller.logindetails["dateOfBirth"],
                      controller.logindetails["mobileNumber"],
                      controller.logindetails["panNumber"],
                      bankname.text,
                      accountholdername.text,
                      accountnumber.text,
                      ifsccode.text,
                      controller.logindetails["profilePicUrl"],
                    );
                    if (result["status"] == "Success") {
                      setState(() {
                        controller.logindetails = result["data"]["exist"];
                      });
                      var snackBar = const SnackBar(
                        elevation: 30,
                        shape: StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(50),
                        content: Text("Bank Details Updated SuccessFully"),
                      );

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.off(() => const Profile());
                    } else {
                      var snackBar = SnackBar(
                        elevation: 30,
                        shape: const StadiumBorder(),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(50),
                        content: Text(result["message"]),
                      );

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 7, 0, 102)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(365, 60)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    controller.logindetails["bankName"] == null &&
                            controller.logindetails["accountHolderName"] ==
                                null &&
                            controller.logindetails["accountNumber"] == null &&
                            controller.logindetails["ifscCode"] == null
                        ? "Setup Bank Account"
                        : "Update Bank Account",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
