// ignore_for_file: avoid_print, prefer_is_empty, prefer_const_declarations, use_build_context_synchronously, type_literal_in_constant_pattern, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:referral_app/screens/payouts/transaction_details.dart';

import '../../Api_call/api_call_functions.dart';
import '../../controllers/getcontroller.dart';

class Payouts extends StatefulWidget {
  const Payouts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PayoutsState createState() => _PayoutsState();
}

class _PayoutsState extends State<Payouts> {
  GlobleVar controller = Get.find();

  Future? payoutsdata;

  @override
  void initState() {
    payoutsdata = initfunc();
    super.initState();
  }

  initfunc() async {
    var temp = await server.getpayouts();
    return temp["data"];
  }

  downloadfile(docurl) async {
    // final taskId = await FlutterDownloader.enqueue(
    //   url: docurl,
    //    headers: {"token":controller.token}, // optional: header send with url (auth token etc)
    //   savedDir: '/storage/emulated/0/Download/',
    //   showNotification:
    //       true, // show download progress in status bar (for Android)
    //   openFileFromNotification: true,
    //   // click on notification to open downloaded file (for Android)
    // );
    HttpClient httpClient = HttpClient();
    File file;

    String filePath = '';

    try {
      var request = await httpClient.getUrl(Uri.parse(docurl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath =
            '/storage/emulated/0/Download/${docurl.toString().split("/").last}';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        print("succes $filePath");
      } else {
        filePath = 'Error code: ${response.statusCode}';
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  Future fileUpload(payoutid) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      var uploadResponse =
          await server.uploadFile(image.path, "signed invoice");

      print("uploadDocument-res $uploadResponse");
      if (uploadResponse["status"] == "Success") {
        var result =await server.uploadsignedinvoice(
            payoutid, uploadResponse["fileDetails"]["path"]);

        if (result["status"] == "Success") {
          final snackBar = const SnackBar(
            elevation: 30,
            shape: StadiumBorder(),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(50),
            content: Text("Image is uploaded Successfully "),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return uploadResponse;
      } else {
        final snackBar = const SnackBar(
          elevation: 30,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(50),
          content: Text("Failed to upload Image "),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    //var width = size.width;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: payoutsdata,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Payouts",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: height * 0.22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(15, 50, 160, 1)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 7, 7, 4),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      // height: height * 0.15,
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent
                                              .withOpacity(0.85),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Payouts Earned",
                                                      style: TextStyle(
                                                          // fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "₹ ${snapshot.data["earnedCommission"]}",
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const VerticalDivider(
                                                thickness: 2,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Expected Payout",
                                                      style: TextStyle(
                                                          // fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "₹ ${snapshot.data["totalCommission"]}",
                                                      style: const TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              style: const ButtonStyle(
                                                  padding:
                                                      MaterialStatePropertyAll(
                                                          EdgeInsets.all(0)),
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.black)),
                                              onPressed: () {
                                                Get.to(() =>
                                                    const TransactionDetails());
                                              },
                                              child: const Text(
                                                  "View Tranaction")),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data["refPayout"].length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${snapshot.data["refPayout"][index]["firstName"]} ${snapshot.data["refPayout"][index]["lastName"]}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Rs. ${snapshot.data["refPayout"][index]["disbursedAmount"]}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "RefId : #12233456",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green
                                                        .withOpacity(0.3)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    "Commission Paid",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Download Invoice"),
                                              Text("Upload Signed Invoice")
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 15, 10, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      // Text("PDF"),
                                                      // SizedBox(
                                                      //   width: 10,
                                                      // ),
                                                      IconButton(
                                                          onPressed: () {
                                                            //fileUpload();
                                                            if (snapshot.data["refPayout"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "invoiceUrl"] !=
                                                                    "" ||
                                                                snapshot.data["refPayout"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "invoiceUrl"] !=
                                                                    null) {
                                                              downloadfile(snapshot
                                                                          .data[
                                                                      "refPayout"][index]
                                                                  [
                                                                  "invoiceUrl"]);
                                                            }
                                                          },
                                                          icon: const Icon(Icons
                                                              .download_rounded)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      // Text("PDF"),
                                                      // SizedBox(
                                                      //   width: 10,
                                                      // ),
                                                      IconButton(
                                                          onPressed: () {
                                                            fileUpload(snapshot
                                                                            .data[
                                                                        "refPayout"]
                                                                    [index][
                                                                "refererPayoutId"]);
                                                          },
                                                          icon: const Icon(Icons
                                                              .upload_rounded)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
