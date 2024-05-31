// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/loginrelated/viewcatalog.dart';

import '../../Api_call/api_call_functions.dart';
import '../../login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showpassword = false;
  bool showconfirmpassword = false;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController phnno = TextEditingController();
  TextEditingController pannumber = TextEditingController();
  TextEditingController corporate = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  DateTime selectedDate = DateTime(DateTime.now().year - 18, 1, 1);
  String changedobft = "";
  final _form = GlobalKey<FormState>();
  bool isValid = false;
  List corporatelist = [];
  Future? corporateresponsedata;

  void saveForm() {
    setState(() {
      isValid = _form.currentState!.validate();
    });
  }

  Future<void> selectDate(BuildContext context) async {
    int year = DateTime.now().year - 18;
    debugPrint("DateTime.now().year - 18");
    debugPrint(year.toString());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(year, 01, 01),
        firstDate: DateTime(year - 100),
        lastDate: DateTime(year, 12, 31));

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        var day =
            selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day;
        var month = selectedDate.month < 10
            ? "0${selectedDate.month}"
            : selectedDate.month;
        var year = selectedDate.year.toString();

        dob.text = "$day-$month-$year";
        changedobft = "$year-$month-$day";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var height = size.height;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(15, 50, 160, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Image.asset(
                  "assets/Logo.png",
                  width: 250,
                ),
              ),
              Container(
                // height: height / 1.25,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Signup Now ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width / 2 - 25,
                                child: TextFormField(
                                  controller: firstname,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == "") {
                                      return "First Name is required";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      label: Text("First Name"),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              SizedBox(
                                width: width / 2 - 25,
                                child: TextFormField(
                                  controller: lastname,
                                  decoration: const InputDecoration(
                                      label: Text("Last Name"),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ],
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
                              if (!(RegExp(r'\S+@\S+\.\S+').hasMatch(value!))) {
                                return "Enter a valid Email Id";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text("Email ID"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: phnno,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == "") {
                                return "Mobile NUmber is required";
                              }
                              if (value!.length != 10) {
                                return "Enter a valid Mobile Number";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text("Mobile Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: dob,
                            onTap: () {
                              selectDate(context);
                            },
                            readOnly: true,
                            validator: (value) {
                              if (value == "") {
                                return "Date of Birth is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: const Text("Date of Birth"),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.calendar_today))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: TextFormField(
                            controller: pannumber,
                            textCapitalization: TextCapitalization.characters,
                            validator: (value) {
                              if (value == "") {
                                return "PAN Number is required";
                              }
                              if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                                  .hasMatch(value!)) {
                                return "Enter a valid Pan Number";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text("PAN Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ExpansionTile(
                            title: const Text("Select Coroperate"),
                            onExpansionChanged: (value) async {
                              if (value) {
                                var result = await server.getcorporatedetails();
                                if (result["status"] == true) {
                                  setState(() {
                                    corporateresponsedata =
                                        Future.delayed(Duration.zero, () {
                                      return result["data"];
                                    });
                                    // opencorporatedialog();
                                  });
                                }
                              }
                            },
                            children: [
                              const Divider(
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: FutureBuilder(
                                  future: corporateresponsedata,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          for (var item in snapshot.data)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Uri.tryParse(item[
                                                                "companyLogoUrl"]) ==
                                                            null
                                                        ? Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Image.asset(
                                                              'assets/Profile Fill.png',
                                                              height: 60,
                                                            ))
                                                        : CircleAvatar(
                                                            radius: 30,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              item[
                                                                  "companyLogoUrl"],
                                                            )),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(item[
                                                            "companyName"]),
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                Viewcatalog(
                                                                  corporateid:
                                                                      item[
                                                                          "id"],
                                                                  titel: item[
                                                                      "companyName"],
                                                                ));
                                                          },
                                                          child: const Text(
                                                              "view Catalog"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      value: corporatelist
                                                          .contains(item["id"]),
                                                      onChanged: (val) {
                                                        setState(() {
                                                          if (corporatelist
                                                              .contains(
                                                                  item["id"])) {
                                                            corporatelist
                                                                .remove(
                                                                    item["id"]);
                                                          } else {
                                                            corporatelist.add(
                                                                item["id"]);
                                                          }
                                                        });
                                                        print(corporatelist);
                                                      })
                                                ],
                                              ),
                                            )
                                        ],
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // corporatelist.length == 0
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(top: 20),
                        //         child: TextFormField(
                        //           controller: corporate,
                        //           readOnly: true,
                        //           validator: (value) {
                        //             if (value == "") {
                        //               return "Coroperate is required";
                        //             }
                        //             return null;
                        //           },
                        //           onTap: () async {
                        //             var result =
                        //                 await server.getcorporatedatails();
                        //             if (result["status"] == true) {
                        //               setState(() {
                        //                 corporateresponsedata = result["data"];
                        //                 opencorporatedialog();
                        //               });
                        //             }
                        //           },
                        //           decoration: const InputDecoration(
                        //               label: Text("Select Coroperate "),
                        //               border: OutlineInputBorder()),
                        //         ),
                        //       )
                        //     : Column(
                        //         children: [
                        //           ListView.builder(
                        //               shrinkWrap: true,
                        //               itemCount: corporatelist.length,
                        //               itemBuilder: (context, index) {
                        //                 return Row(
                        //                   children: [
                        //                     Text(
                        //                         corporatelist[index].toString())
                        //                   ],
                        //                 );
                        //               }),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.end,
                        //             children: [
                        //               TextButton(
                        //                   onPressed: () {
                        //                     opencorporatedialog();
                        //                   },
                        //                   child: Text("Add Corporates.."))
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: password,
                            obscuringCharacter: '*',
                            obscureText: !showpassword,
                            validator: (value) {
                              if (value == "") {
                                return "PassWord is required";
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
                          child: TextFormField(
                            controller: confirmpassword,
                            obscuringCharacter: '*',
                            obscureText: !showconfirmpassword,
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
                                      showconfirmpassword =
                                          !showconfirmpassword;
                                    });
                                  },
                                  icon: showconfirmpassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                label: const Text("Confirm Password"),
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
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(15, 50, 160, 1))),
                                  onPressed: () async {
                                    saveForm();
                                    if (isValid && corporatelist.length != 0) {
                                      var templist = [];
                                      for (var item in corporatelist) {
                                        templist.add({"corporateId": item});
                                      }
                                      print(templist);
                                      var result = await server.signUp(
                                          firstname.text,
                                          lastname.text,
                                          emailid.text,
                                          changedobft,
                                          pannumber.text,
                                          phnno.text,
                                          password.text,
                                          templist);

                                      if (result["status"] == "Success") {
                                        Get.off(() => const Login());
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
                                    } else {
                                      var snackBar = const SnackBar(
                                        elevation: 30,
                                        shape: StadiumBorder(),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(50),
                                        content: Text(
                                            "Please Fill All the Fieldes and select Corporate to Continue.."),
                                      );
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text("Sign up",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  // opencorporatedialog() {
  //   var size = MediaQuery.of(context).size;
  //   var height = size.height;
  //   var width = size.width;
  //   return Get.dialog(
  //     StatefulBuilder(builder: (BuildContext context, setState) {
  //       return Scaffold(
  //         backgroundColor: Colors.transparent,
  //         body: Center(
  //           child: Container(
  //             height: height * 0.4,
  //             width: width - 40,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10), color: Colors.white),
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: corporateresponsedata.length,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(10),
  //                   child: Row(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(right: 10),
  //                         child: CircleAvatar(
  //                             radius: 30,
  //                             backgroundImage: NetworkImage(
  //                               corporateresponsedata[index]["companyLogoUrl"],
  //                             )),
  //                       ),
  //                       Expanded(
  //                         child:
  //                             Text(corporateresponsedata[index]["companyName"]),
  //                       ),
  //                       Checkbox(
  //                           value: corporatelist
  //                               .contains(corporateresponsedata[index]["id"]),
  //                           onChanged: (val) {
  //                             setState(() {
  //                               if (corporatelist.contains(
  //                                   corporateresponsedata[index]["id"])) {
  //                                 corporatelist.remove(
  //                                     corporateresponsedata[index]["id"]);
  //                               } else {
  //                                 corporatelist
  //                                     .add(corporateresponsedata[index]["id"]);
  //                               }
  //                             });
  //                             print(corporatelist);
  //                           })
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }
}
