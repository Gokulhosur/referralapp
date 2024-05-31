// ignore_for_file: prefer_const_declarations, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/homepage.dart';

import '../../Api_call/api_call_functions.dart';
import '../../controllers/getcontroller.dart';
//import 'package:get/get.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  GlobleVar controller = Get.find();

  List submitlist = [];
  TextEditingController bankdetails = TextEditingController();
  TextEditingController aadhaar = TextEditingController();
  TextEditingController pancard = TextEditingController();
  TextEditingController otherdocument = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(controller.referdoc);
    initfunc();
  }

  initfunc() {
    setState(() {
  for (var g = 0; g < controller.referdoc.length; g++) {
    submitlist.add({
      "id": controller.referdoc[g]["documentTypeMasterId"],
      "filepath": controller.referdoc[g]["documentUrl"],
      "filename":
          controller.referdoc[g]["documentUrl"].toString().split("/").last
    });
    switch (controller.referdoc[g]["documentTypeMasterId"]) {
      case 1:
        bankdetails.text =
            controller.referdoc[g]["documentUrl"].toString().split("/").last;
      case 2:
        aadhaar.text =
            controller.referdoc[g]["documentUrl"].toString().split("/").last;
      case 3:
        pancard.text =
            controller.referdoc[g]["documentUrl"].toString().split("/").last;
      case 4:
        otherdocument.text =
            controller.referdoc[g]["documentUrl"].toString().split("/").last;
    }
  }
});
  }

  Future pickgalleryImage(type, id) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var temp = await server.uploadFile(image.path, type);

      if (temp["status"] == "Success") {
        setState(() {
          if (submitlist.isEmpty) {
            submitlist.add({
              "id": id,
              "filepath": temp["fileDetails"]["path"],
              "filename": temp["fileDetails"]["fileName"]
            });
          } else {
            var duplecat =
                submitlist.indexWhere((element) => element["id"] == id);
            print("duplecat  $duplecat");
            if (duplecat == -1) {
              submitlist.add({
                "id": id,
                "filepath": temp["fileDetails"]["path"],
                "filename": temp["fileDetails"]["fileName"]
              });
            } else {
              submitlist[duplecat]["filepath"] = temp["fileDetails"]["path"];
              submitlist[duplecat]["filename"] =
                  temp["fileDetails"]["fileName"];
            }
          }
          switch (id) {
            case 1:
              bankdetails.text = temp["fileDetails"]["fileName"];
            case 2:
              aadhaar.text = temp["fileDetails"]["fileName"];
            case 3:
              pancard.text = temp["fileDetails"]["fileName"];
            case 4:
              otherdocument.text = temp["fileDetails"]["fileName"];
          }
        });
        print(submitlist);
        debugPrint("called1");

        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Image uploaded Successfully "),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return image.path;
      } else {
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Failed to upload Image "),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return "failed";
      }
    } on PlatformException catch (e) {
      throw ('Failed to pick image: $e');
    }
  }

  Future pickcameraImage(type, id) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      debugPrint("image1234");
      debugPrint(image.toString());
      if (image == null) return;
      var temp = await server.uploadFile(image.path, type);

      if (temp["status"] == "Success") {
        setState(() {
          if (submitlist.isEmpty) {
            submitlist.add({
              "id": id,
              "filepath": temp["fileDetails"]["path"],
              "filename": temp["fileDetails"]["fileName"]
            });
          } else {
            var duplecat =
                submitlist.indexWhere((element) => element["id"] == id);
            print("duplecat  $duplecat");
            if (duplecat == -1) {
              submitlist.add({
                "id": id,
                "filepath": temp["fileDetails"]["path"],
                "filename": temp["fileDetails"]["fileName"]
              });
            } else {
              submitlist[duplecat]["filepath"] = temp["fileDetails"]["path"];
              submitlist[duplecat]["filename"] =
                  temp["fileDetails"]["fileName"];
            }
          }
          switch (id) {
            case 1:
              bankdetails.text = temp["fileDetails"]["fileName"];
            case 2:
              aadhaar.text = temp["fileDetails"]["fileName"];
            case 3:
              pancard.text = temp["fileDetails"]["fileName"];
            case 4:
              otherdocument.text = temp["fileDetails"]["fileName"];
          }
        });
        print(submitlist);
        debugPrint("called1");
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Image uploaded Successfully "),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return image.path;
      } else {
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Failed to upload Image "),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return "failed";
      }
    } on PlatformException catch (e) {
      throw ('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 1, 134),
          title: const Text("Upload Documents"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 30,
                  ),
                  child: Text(
                    "Please upload the photocopy of documents which given below",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "Bank Details",
                //         style: TextStyle(fontWeight: FontWeight.w500),
                //       ),
                //       const SizedBox(
                //         height: 5,
                //       ),
                //       DropdownButtonFormField<String>(
                //         isExpanded: true,
                //         borderRadius: BorderRadius.circular(5),
                //         value: dropdownvalue,
                //         decoration:
                //             const InputDecoration(border: OutlineInputBorder()),
                //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
                //         items: const [
                //           DropdownMenuItem<String>(
                //               value: 'one', child: Text("Bank Statement")),
                //           DropdownMenuItem<String>(
                //               value: 'two',
                //               child: Text(
                //                 "Canceled Check",
                //               )),
                //           // DropdownMenuItem<String>(
                //           //     value: 'three', child: Text("Option2")),
                //         ],
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             dropdownvalue = newValue!;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Bank Details",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bankdetails,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await pickgalleryImage(
                                              "bank statement", 1);
                                        },
                                        icon: const Icon(Icons.upload_rounded)),
                                    IconButton(
                                        onPressed: () async {
                                          await pickcameraImage(
                                              "bank statement", 1);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded))
                                  ],
                                )

                                // ElevatedButton(
                                //     style: ButtonStyle(
                                //         // minimumSize: MaterialStateProperty.all(
                                //         //     const Size(150, 20)),
                                //         shape: MaterialStateProperty.all(
                                //             RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(6)))),
                                //     onPressed: () {},
                                //     child: const Row(
                                //       mainAxisSize: MainAxisSize.min,
                                //       children: [
                                //         Text(
                                //           "Upload File",
                                //           // style: TextStyle(color: Colors.black),
                                //         ),
                                //         Icon(Icons.file_upload_outlined)
                                //       ],
                                //     )),

                                ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Divider(
                //   thickness: 2,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "Personal ID",
                //         style: TextStyle(fontWeight: FontWeight.w500),
                //       ),
                //       const SizedBox(
                //         height: 5,
                //       ),
                //       DropdownButtonFormField<String>(
                //         isExpanded: true,
                //         borderRadius: BorderRadius.circular(5),
                //         value: dropdownvalue,
                //         decoration:
                //             const InputDecoration(border: OutlineInputBorder()),
                //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
                //         items: const [
                //           // DropdownMenuItem<String>(
                //           //     value: 'one', child: Text("--Select--")),
                //           DropdownMenuItem<String>(
                //               value: 'one',
                //               child: Text(
                //                 "Aadhaar",
                //                 style: TextStyle(),
                //               )),
                //           // DropdownMenuItem<String>(
                //           //     value: 'three', child: Text("Option2")),
                //         ],
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             dropdownvalue = newValue!;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Aadhaar",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: aadhaar,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await pickgalleryImage("Aadhaar", 2);
                                        },
                                        icon: const Icon(Icons.upload_rounded)),
                                    IconButton(
                                        onPressed: () async {
                                          await pickcameraImage("Aadhaar", 2);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded))
                                  ],
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const Divider(
                //   thickness: 2,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload PAN Card",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: pancard,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await pickgalleryImage("PAN card", 3);
                                        },
                                        icon: const Icon(Icons.upload_rounded)),
                                    IconButton(
                                        onPressed: () async {
                                          await pickcameraImage("PAN card", 3);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded))
                                  ],
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Other Documents",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: otherdocument,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await pickgalleryImage(
                                              "Other Documents", 4);
                                        },
                                        icon: const Icon(Icons.upload_rounded)),
                                    IconButton(
                                        onPressed: () async {
                                          await pickcameraImage(
                                              "Other Documents", 4);
                                        },
                                        icon: const Icon(
                                            Icons.camera_alt_rounded))
                                  ],
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ],
                  ),
                ),
                submitlist.length == 0
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < submitlist.length; i++)
                                      SizedBox(
                                          height: 110,
                                          width: 105,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Image.network(
                                                  submitlist[i]["filepath"],
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        switch (submitlist[i]
                                                            ["id"]) {
                                                          case 1:
                                                            bankdetails.text =
                                                                "";
                                                          case 2:
                                                            aadhaar.text = "";
                                                          case 3:
                                                            pancard.text = "";
                                                          case 4:
                                                            otherdocument.text =
                                                                "";
                                                        }
                                                        submitlist.removeAt(i);
                                                        print(submitlist);
                                                      });
                                                    },
                                                    child: const Icon(
                                                        Icons.cancel_outlined)),
                                              )
                                            ],
                                          ))
                                  ],
                                ),
                              ),
                            )),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            var tempsendlist = [];
                            for (int j = 0; j < submitlist.length; j++) {
                              tempsendlist.add({
                                "id": 0,
                                "refererDetailsId":
                                    controller.logindetails["id"],
                                "documentTypeMasterId": submitlist[j]["id"],
                                "documentUrl": submitlist[j]["filepath"]
                              });
                            }
                            print(tempsendlist);
                            var result =
                                await server.updatedocuments(tempsendlist);
                            if (result["status"] == "Success") {
                              final snackBar = const SnackBar(
                                elevation: 30,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(50),
                                content:
                                    Text("documents uploaded Successfully "),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Get.off(() => const Homepage(
                                    pageno: 4,
                                  ));
                            } else {
                              final snackBar = const SnackBar(
                                elevation: 30,
                                shape: StadiumBorder(),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(50),
                                content: Text(
                                    "documents uploaded Failed try again "),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 7, 0, 102)),
                              // minimumSize:
                              //     MaterialStateProperty.all(const Size(365, 60)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
