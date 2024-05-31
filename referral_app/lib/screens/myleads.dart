import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Api_call/api_call_functions.dart';

class Myleads extends StatefulWidget {
  const Myleads({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyleadsState createState() => _MyleadsState();
}

class _MyleadsState extends State<Myleads> {
  Future? alldetails;
  @override
  void initState() {
    super.initState();
    alldetails = intfunction();
  }

  intfunction() async {
    var detailstemp = await server.leadsdetailsbyrefid(0);
    return detailstemp["data"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "My Leads",
            style: TextStyle(color: Colors.black),
          ),
          forceMaterialTransparency: true,
        ),
        body: FutureBuilder(
            future: alldetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      color: const Color.fromRGBO(15, 50, 160, 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Total Leads(${snapshot.data.length})",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search,
                                      size: 30, color: Colors.white),
                                ),
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/Filter.png",
                                    color: Colors.white,
                                    height: 25,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Card(
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
                                              snapshot.data[index]
                                                      ["applicantFirstName"] +
                                                  " " +
                                                  snapshot.data[index]
                                                      ["applicantLastName"],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "${snapshot.data[index]["expectedLoanAmount"]}",
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
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat('dd MMMM yyyy')
                                                    .format(DateTime.parse(
                                                        snapshot.data[index][
                                                            "lastUpdatedDate"]))
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                        5),
                                                    color: snapshot.data[index]["leadsStatus"] ==
                                                            "Submitted"
                                                        ? Colors.green
                                                            .withOpacity(0.2)
                                                        //  const Color
                                                        //     .fromRGBO(
                                                        //     15,
                                                        //     50,
                                                        //     160,
                                                        //     1)
                                                        : snapshot.data[index]["leadsStatus"] ==
                                                                "Not Submitted"
                                                            ? const Color.fromRGBO(
                                                                255, 235, 210, 1)
                                                            : snapshot.data[index]["leadsStatus"] ==
                                                                    "In-Process"
                                                                ? const Color.fromRGBO(
                                                                    225, 255, 254, 1)
                                                                : snapshot.data[index]["leadsStatus"] ==
                                                                        "Under Review"
                                                                    ? const Color.fromRGBO(
                                                                        250,
                                                                        230,
                                                                        240,
                                                                        1)
                                                                    : const Color.fromRGBO(
                                                                        15,
                                                                        50,
                                                                        160,
                                                                        1)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    snapshot.data[index]
                                                        ["leadsStatus"],
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
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
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
