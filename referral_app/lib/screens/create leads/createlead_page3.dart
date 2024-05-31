// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/Api_call/api_call_functions.dart';

import '../../controllers/getcontroller.dart';
import '../../homepage.dart';

class CreateleadPage3 extends StatefulWidget {
  const CreateleadPage3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateleadPage3State createState() => _CreateleadPage3State();
}

class _CreateleadPage3State extends State<CreateleadPage3> {
  GlobleVar controller = Get.find();
  List organization = ["Private", "Public", "Self Employed"];
  List lonetype = ["Jewel", "Housing", "Personal"];

  final _form = GlobalKey<FormState>();
  bool isValid = false;

  void saveForm() {
    setState(() {
      isValid = _form.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              color: Colors.black,
              size: 40,
            ),
          ),
          title: const Text(
            "New Lead",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(15, 50, 160, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.yellow),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Personal Info",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.yellow),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Residential",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.checklist_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(15, 50, 160, 1)),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Requirrement",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        commondropdown(
                            "Organization", organization, "organization"),
                        commontextfield("Name of the Organization", "",
                            "nameoftheorganization"),
                        commontextfield("Annuual Income", "", "annuualincome"),
                        commontextfield("PAN Number", "", "pannumber"),
                        commondropdown("Loan Type", lonetype, "loantype"),
                        commontextfield(
                            "Expected Loan Amount", "", "expectedloanamount"),
                        commontextfield("Loan Purpose", "", "loanpurpose"),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Expanded(
                                child: SizedBox(
                               // width: 20,
                              ),
                                //  ElevatedButton(
                                //     style: const ButtonStyle(
                                //       backgroundColor: MaterialStatePropertyAll(
                                //         Color(0xFF0F32A0),
                                //       ),
                                //     ),
                                //     onPressed: () {},
                                //     child: const Text(
                                //       "Save as Draft",
                                //       style: TextStyle(fontSize: 18),
                                //     )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF0F32A0),
                                      ),
                                    ),
                                    onPressed: () async {
                                      saveForm();
                                      if (isValid) {
                                        debugPrint(
                                            controller.newleadmap.toString());
                                        var result = await server.newleads();
                                        if (result["status"] == "Success") {
                                          var snackBar = SnackBar(
                                            elevation: 30,
                                            shape: const StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: const EdgeInsets.all(50),
                                            content: Text(
                                                result["message"].toString()),
                                          );

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Get.offAll(() => const Homepage(
                                                pageno: 0,
                                              ));
                                        } else {
                                          var snackBar = const SnackBar(
                                            elevation: 30,
                                            shape: StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(50),
                                            content:
                                                Text("some thing Failed.."),
                                          );

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget commontextfield(lable, hint, keyval) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            onChanged: (val) {
              setState(() {
                controller.newleadmap.addAll({keyval: val});
                debugPrint(controller.newleadmap.toString());
              });
            },
            keyboardType:
                lable == "Expected Loan Amount" || lable == "Annuual Income"
                    ? TextInputType.number
                    : null,
            validator: (val) {
              if (val == "") {
                return lable + "is reqired";
              }
              if (lable == "PAN Number") {
                if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(val!)) {
                  return "Enter a valid $lable";
                }
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: hint, border: const OutlineInputBorder()),
          )
        ],
      ),
    );
  }

  Widget commondropdown(lable, List list, keyval) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 6,
          ),
          DropdownButtonFormField(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: const InputDecoration(
                hintText: "Select",
                border: OutlineInputBorder(),
              ),
              items: list
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  controller.newleadmap.addAll({keyval: val});
                  debugPrint(controller.newleadmap.toString());
                });
              }),
        ],
      ),
    );
  }
}
