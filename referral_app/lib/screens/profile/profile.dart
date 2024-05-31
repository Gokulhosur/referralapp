// ignore_for_file: prefer_const_declarations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:referral_app/login.dart';

import '../../Api_call/api_call_functions.dart';
import '../../controllers/getcontroller.dart';
import 'setup_bank.dart';
import 'upload_documents.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobleVar controller = Get.find();

  Future pickgalleryImage(type) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      var temp = await server.uploadFile(image.path, "profile");

      if (temp["status"] == "Success") {
        debugPrint("called1");
        var results = await server.updateprofilepic(
          controller.logindetails["firstName"],
          controller.logindetails["lastName"],
          controller.logindetails["emailId"],
          controller.logindetails["dateOfBirth"],
          controller.logindetails["mobileNumber"],
          controller.logindetails["panNumber"],
          temp["fileDetails"]["path"],
          controller.logindetails["bankName"],
          controller.logindetails["accountHolderName"],
          controller.logindetails["accountNumber"],
          controller.logindetails["ifscCode"],
        );

        if (results["status"] == "Success") {
          setState(() {
            controller.logindetails = results["data"]["exist"];
          });
          final snackBar = const SnackBar(
            elevation: 30,
            shape: StadiumBorder(),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(50),
            content: Text("Image is uploaded Successfully "),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          return image.path;
        }
      } else {
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Failed to upload Image "),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //  return "failed";
      }
    } on PlatformException catch (e) {
      throw ('Failed to pick image: $e');
    }
  }

  Future pickcameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      debugPrint("image1234");
      debugPrint(image.toString());
      if (image == null) return;

      var temp = await server.uploadFile(image.path, "profile");

      if (temp["status"] == "Success") {
        debugPrint("called1");
        var results = await server.updateprofilepic(
          controller.logindetails["firstName"],
          controller.logindetails["lastName"],
          controller.logindetails["emailId"],
          controller.logindetails["dateOfBirth"],
          controller.logindetails["mobileNumber"],
          controller.logindetails["panNumber"],
          temp["fileDetails"]["path"],
          controller.logindetails["bankName"],
          controller.logindetails["accountHolderName"],
          controller.logindetails["accountNumber"],
          controller.logindetails["ifscCode"],
        );

        if (results["status"] == "Success") {
          setState(() {
            controller.logindetails = results["data"]["exist"];
          });
          final snackBar = const SnackBar(
            elevation: 30,
            shape: StadiumBorder(),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(50),
            content: Text("Image is uploaded Successfully "),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          return image.path;
        }
      } else {
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Failed to upload Image "),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //  return "failed";
      }
    } on PlatformException catch (e) {
      throw ('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                pickcameraImage();
              },
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
                child: Stack(children: [
                  Center(
                    child: controller.logindetails["profilePicUrl"] == null ||
                            controller.logindetails["profilePicUrl"] == ""
                        ? Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 10, 1, 134),
                                shape: BoxShape.circle),
                            child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      'assets/Profile Fill.png',
                                      height: 170,
                                    ))),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              controller.logindetails["profilePicUrl"],
                            ),
                          ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child:
                          //  ElevatedButton(
                          //     onPressed: () {},
                          //     style: ButtonStyle(
                          //         backgroundColor: MaterialStateProperty.all(
                          //             const Color.fromARGB(255, 10, 1, 134)),
                          //         shape: MaterialStateProperty.all(
                          //             const CircleBorder())),
                          //     child:
                          Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 10, 1, 134),
                            shape: BoxShape.circle),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                      //    )
                      )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 19, right: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Full Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.logindetails["firstName"] +
                        " " +
                        controller.logindetails["lastName"],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 19, right: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email ID",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.logindetails["emailId"],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 19, right: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Mobile Number",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.logindetails["mobileNumber"],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 19, right: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Date of Birth",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat("dd MMMM yyyy")
                        .format(DateTime.parse(
                            controller.logindetails["dateOfBirth"]))
                        .toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              endIndent: 7,
              indent: 7,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const BankSetup()); //BankDetails());
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 5, left: 19, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const UploadDocuments()); //Documents());
              },
              child: const Padding(
                padding: EdgeInsets.only(
                    top: 15, bottom: 10, left: 19, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Documents",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.offAll(() => const Login());
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 19, right: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Logout",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                    Image.asset("assets/Logout.png")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
