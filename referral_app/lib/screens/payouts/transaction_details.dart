// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Api_call/api_call_functions.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  var dropvalues = ["Last 7 Days"];
  var selectedval;
  Map<String, dynamic> dummydata = {};

  //List dummydata = [];
  //   {
  //     "date": "Today",
  //     "dateval": [
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //     ]
  //   },
  //   {
  //     "date": "20 March 2024",
  //     "dateval": [
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //     ]
  //   },
  //   {
  //     "date": "18 March 2024",
  //     "dateval": [
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //       {
  //         "name": "gokul",
  //         "requestedammount": "₹ 1500000",
  //         "totalcommission": "₹ 5000",
  //         "earning": "₹ 600",
  //         "pending": "₹ 500"
  //       },
  //     ]
  //   }
  // ];

  Future? payoutsdata;
  @override
  void initState() {
    payoutsdata = initfunc();
    super.initState();
  }

  initfunc() async {
    var result = await server.getpayouttransation();
    var temp = result["data"];
    for (var item in temp) {
      print("hello length  ${dummydata.length}   ${temp.length}");

      if (dummydata.length == 0) {
        if (item["transactionDate"].toString() != "null") {
          dummydata.addAll({
            DateFormat("dd MMMM yyyy")
                .format(DateTime.parse(item["transactionDate"])): [item]
          });
        }
      } else {
        if (item["transactionDate"].toString() != "null") {
          if (dummydata.keys.contains(DateFormat("dd MMMM yyyy")
              .format(DateTime.parse(item["transactionDate"])))) {
            dummydata[DateFormat("dd MMMM yyyy")
                    .format(DateTime.parse(item["transactionDate"]))]
                .add(item);
          } else {
            dummydata.addAll({
              DateFormat("dd MMMM yyyy")
                  .format(DateTime.parse(item["transactionDate"])): [item]
            });
          }
        }
      }
    }
    print(dummydata);
    return dummydata;
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
            "Transaction Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(15, 50, 160, 1)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    const Text(
                      "Show Transaction from",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              dropdownColor: Colors.black,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              value: selectedval ?? dropvalues[0],
                              items: dropvalues
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        //style: TextStyle(color: Colors.white),
                                      )))
                                  .toList(),
                              onChanged: (val) {}),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        // ignore: prefer_const_constructors
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder(
                  future: payoutsdata,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length == 0
                          ? const Center(
                              child: Text("No Transaction Yet"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                child: Divider(
                                              thickness: 2,
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                snapshot.data.keys
                                                            .elementAt(index) ==
                                                        DateFormat(
                                                                "dd MMMM yyyy")
                                                            .format(
                                                                DateTime.now())
                                                    ? " today "
                                                    : snapshot.data.keys
                                                        .elementAt(index)
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                                child: Divider(
                                              thickness: 2,
                                            )),
                                          ],
                                        ),
                                      ),
                                      for (int i = 0;
                                          i <
                                              snapshot.data.values
                                                  .elementAt(index)
                                                  .length;
                                          i++)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Referrer Name",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${snapshot.data.values.elementAt(index)[i]["applicantFirstName"]} ${snapshot.data.values.elementAt(index)[i]["applicantLastName"]}"
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Requested Loan Amount",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            snapshot.data.values
                                                                .elementAt(index)[
                                                                    i][
                                                                    "expectedLoanAmount"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  indent: 8,
                                                  endIndent: 8,
                                                  thickness: 2,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Total Commission",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            snapshot.data.values
                                                                .elementAt(index)[
                                                                    i][
                                                                    "totalCommission"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Earned",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            snapshot.data.values
                                                                .elementAt(index)[
                                                                    i][
                                                                    "earnedCommission"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Pending",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            snapshot.data.values
                                                                .elementAt(index)[
                                                                    i][
                                                                    "balanceCommission"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (snapshot.data.values
                                                                      .elementAt(
                                                                          index)[i]
                                                                  [
                                                                  "invoiceUrl"] !=
                                                              "") {
                                                            Get.dialog(
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        30),
                                                                child: Image.network(snapshot
                                                                    .data.values
                                                                    .elementAt(index)[
                                                                        i][
                                                                        "balanceCommission"]
                                                                    .toString()),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black12,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                                "View Invoice"),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (snapshot.data.values
                                                                      .elementAt(
                                                                          index)[i]
                                                                  [
                                                                  "signedInvoiceUrl"] !=
                                                              "") {
                                                            Get.dialog(
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        30),
                                                                child: Image.network(snapshot
                                                                    .data.values
                                                                    .elementAt(index)[
                                                                        i][
                                                                        "signedInvoiceUrl"]
                                                                    .toString()),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black12,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Text(
                                                                "View Signed Invoice"),
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
                                    ],
                                  ),
                                );
                              });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
