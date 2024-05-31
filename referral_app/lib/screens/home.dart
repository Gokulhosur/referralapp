import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:referral_app/Api_call/api_call_functions.dart';
import 'package:referral_app/screens/loginrelated/viewcatalog.dart';

import '../controllers/getcontroller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobleVar controller = Get.find();
  int selectedindex = 0;
  List gridelements = [
    {"value": "60", "name": "Total Leads", "statusId": "0"},
    {"value": "6", "name": "Submitted", "statusId": "1"},
    {"value": "12", "name": "Approved", "statusId": "4"},
    {"value": "7", "name": "In-Process", "statusId": "3"},
    {"value": "3", "name": "Sanctioned", "statusId": "5"},
    {"value": "17", "name": "Disbursed", "statusId": "6"},
  ];

  Future? leaddetails;

  @override
  void initState() {
    super.initState();
    leaddetails = intfunction(0);
  }

  intfunction(statustype) async {
    var temp = await server.leadscount();
    var detailstemp = await server.leadsdetailsbyrefid(statustype);
    if (temp["status"] == "Success") {
      setState(() {
        gridelements[0]["value"] = temp["data"]["totalCount"].toString();
        gridelements[1]["value"] = temp["data"]["submitted"].toString();
        gridelements[2]["value"] = temp["data"]["approved"].toString();
        gridelements[3]["value"] = temp["data"]["inProcess"].toString();
        gridelements[4]["value"] = temp["data"]["sanctioned"].toString();
        gridelements[5]["value"] = temp["data"]["disbursed"].toString();
      });
    }
    return detailstemp["data"];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        bottom: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.black12,
          appBar: AppBar(
            elevation: 0, backgroundColor: Colors.white,
            //forceMaterialTransparency: true,
            title: DropdownButtonFormField(
              //isDense: false,
              //isExpanded: true,
              value: controller.corporateid,
              items: controller.corporatedetails
                  .map((item) => DropdownMenuItem(
                        child: Text(item["companyName"].toString()),
                        value: item["corporateDetailsId"],
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  controller.corporateid = value;
                });
              },
            ), // Image.asset("assets/Menu icon.png"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.to(() => Viewcatalog(
                        corporateid: controller.corporateid, titel: ""));
                  },
                  child: const Text("View Catalog"))
              //   IconButton(
              //     onPressed: () {},
              //     icon: Image.asset("assets/Message icon.png"),
              //   ),
              //   IconButton(
              //       onPressed: () {},
              //       icon: Image.asset("assets/Notification icon.png"))
            ],
          ),
          body: FutureBuilder(
              future: leaddetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height / 2 - 90,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Wellcome Back, ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        controller.logindetails["firstName"] +
                                            " " +
                                            controller.logindetails["lastName"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset("assets/Filter.png"),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1.1,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 15),
                                    itemCount: gridelements.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          // Future temp =
                                          setState(() {
                                            selectedindex = index;
                                            leaddetails = intfunction(
                                                gridelements[index]
                                                    ["statusId"]);
                                          });
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: selectedindex == index
                                                  ? const Color.fromRGBO(
                                                      15, 50, 160, 1)
                                                  : Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    gridelements[index]
                                                        ["value"],
                                                    style: TextStyle(
                                                        color: selectedindex ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text(
                                                    gridelements[index]["name"],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          selectedindex == index
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Totel Leads(${gridelements[0]["value"]})"),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text("See All"))
                                  ],
                                ),
                                Expanded(
                                  child: snapshot.data.length == 0
                                      ? const Center(
                                          child: Text("NO Leads Created Yet"),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data[index][
                                                                "applicantFirstName"] +
                                                            " " +
                                                            snapshot.data[index]
                                                                [
                                                                "applicantLastName"],
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        "${snapshot.data[index]["expectedLoanAmount"]}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  'dd MMMM yyyy')
                                                              .format(DateTime.parse(
                                                                  snapshot.data[
                                                                          index]
                                                                      [
                                                                      "lastUpdatedDate"]))
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: snapshot.data[index][
                                                                              "leadsStatus"] ==
                                                                          "New"
                                                                      ? Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.2)
                                                                      //  const Color
                                                                      //     .fromRGBO(
                                                                      //     15,
                                                                      //     50,
                                                                      //     160,
                                                                      //     1)
                                                                      : snapshot.data[index]["leadsStatus"] ==
                                                                              "Not Submitted"
                                                                          ? const Color.fromRGBO(
                                                                              255,
                                                                              235,
                                                                              210,
                                                                              1)
                                                                          : snapshot.data[index]["leadsStatus"] == "In-Process"
                                                                              ? const Color.fromRGBO(225, 255, 254, 1)
                                                                              : snapshot.data[index]["leadsStatus"] == "Under Review"
                                                                                  ? const Color.fromRGBO(250, 230, 240, 1)
                                                                                  : const Color.fromRGBO(15, 50, 160, 1)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Text(
                                                              snapshot.data[
                                                                      index][
                                                                  "leadsStatus"],
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
