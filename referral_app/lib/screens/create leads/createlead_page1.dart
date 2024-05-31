// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/create%20leads/createlead_page2.dart';

import '../../controllers/getcontroller.dart';

class CreateleadPage1 extends StatefulWidget {
  const CreateleadPage1({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateleadPage1State createState() => _CreateleadPage1State();
}

class _CreateleadPage1State extends State<CreateleadPage1> {
  GlobleVar controller = Get.find();
  List maritalstatus = ["Single", "Married"];
  List gender = ["Male", "Female", "Others"];
  DateTime selectedDate = DateTime(DateTime.now().year - 18, 1, 1);
  String changedobft = "";

  final _form = GlobalKey<FormState>();
  bool isValid = false;

  void saveForm() {
    setState(() {
      isValid = _form.currentState!.validate();
    });
  }

  Future<List<String>> selectDate(BuildContext context) async {
    int year = DateTime.now().year - 18;
    debugPrint("DateTime.now().year - 18");
    debugPrint(year.toString());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(year, 01, 01),
        firstDate: DateTime(year - 100),
        lastDate: DateTime(year, 12, 31));

    if (picked != null) {
      // setState(() {
      selectedDate = picked;
      var day =
          selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day;
      var month = selectedDate.month < 10
          ? "0${selectedDate.month}"
          : selectedDate.month;
      var year = selectedDate.year.toString();

      // changedobft = ;
      //  });
      return ["$day-$month-$year", "$year-$month-$day"];
    }
    return [""];
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
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "1",
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
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "2",
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
                        commontextfield(
                            "First Name *", "As per PAN Card", "firstname"),
                        commontextfield(
                            "Last Name *", "As per PAN Card", "lastname"),
                        commontextfield("Mobile Number", "", "mobileno"),
                        commontextfield("Date of Birth", "DD/MM/YYYY", "dob"),
                        commontextfield("Email Address(Official)",
                            "example@gmail.com", "emailid"),
                        commondropdown(
                            "Marital Status", maritalstatus, "maritalstatus"),
                        commondropdown("Gender", gender, "gender"),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Expanded(
                                child: SizedBox(
                                //width: 20,
                              ),
                                //  ElevatedButton(
                                //     style: const ButtonStyle(
                                //         backgroundColor:
                                //             MaterialStatePropertyAll(
                                //                 Color.fromRGBO(
                                //                     15, 50, 160, 1))),
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    15, 50, 160, 1))),
                                    onPressed: () {
                                      saveForm();
                                      if (isValid) {
                                        Get.to(() => const CreateleadPage2());
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
            controller: lable == "Date of Birth"
                ? TextEditingController(
                    text: controller.newleadmap["dob"] != null
                        ? controller.newleadmap["dob"][0]
                        : "")
                : null,
            validator: (val) {
              if (val == "") {
                return lable + "is reqired";
              }
              if (lable == "Mobile Number") {
                if (val!.length != 10) {
                  return "Enter a valied $lable";
                }
              }
              if (keyval == "emailid") {
                if (!(RegExp(r'\S+@\S+\.\S+').hasMatch(val!))) {
                  return "Enter a valid Email Id";
                }
              }
              
              return null;
            },
            readOnly: lable == "Date of Birth" ? true : false,
            onChanged: (val) {
              setState(() {
                controller.newleadmap.addAll({keyval: val});
                debugPrint(controller.newleadmap.toString());
              });
            },
            onTap: () async {
              if (lable == "Date of Birth") {
                var dobdate = await selectDate(context);
                setState(() {
                  controller.newleadmap.addAll({keyval: dobdate});
                });
                debugPrint(controller.newleadmap.toString());
              }
            },
            decoration: InputDecoration(
                prefixIcon: lable == "Mobile Number"
                    ? const IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "+91",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded),
                            VerticalDivider(
                              thickness: 2,
                            )
                          ],
                        ),
                      )
                    : null,
                suffixIcon: lable == "Date of Birth"
                    ? const Icon(Icons.calendar_today_rounded)
                    : null,
                hintText: hint,
                border: const OutlineInputBorder()),
            keyboardType:
                lable == "Mobile Number" ? TextInputType.number : null,
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
              validator: (val) {
                if (val == null) {
                  return lable + "is reqired";
                }
                return null;
              },
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
