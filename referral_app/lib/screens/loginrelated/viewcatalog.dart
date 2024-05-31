import 'package:flutter/material.dart';
import 'package:referral_app/Api_call/api_call_functions.dart';

class Viewcatalog extends StatefulWidget {
  final corporateid;
  final titel;
  const Viewcatalog(
      {super.key, required this.corporateid, required this.titel});

  @override
  // ignore: library_private_types_in_public_api
  _ViewcatalogState createState() => _ViewcatalogState();
}

class _ViewcatalogState extends State<Viewcatalog> {
  Future? catalogdetails;
  @override
  void initState() {
    super.initState();
    catalogdetails = initfunction();
  }

  initfunction() async {
    var temp = await server.getcorporatecatalog(widget.corporateid);
    return temp["data"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.titel),
        ),
        body: FutureBuilder(
          future: catalogdetails,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length == 0
                  ? const Center(
                      child: Text("No Catalog Available For this Corporate"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: ExpansionTile(
                                  title: Text(snapshot.data[index]["loanType"]),
                                  children: [
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot
                                              .data[index]["commission"].length,
                                          itemBuilder: (context, i) {
                                            return Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
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
                                                          "Amount:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                            "${snapshot.data[index]["commission"][i]["amount"].round()}")
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Commission Type:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                            "${snapshot.data[index]["commission"][i]["commissionType"]}")
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Commission:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                            "${(snapshot.data[index]["commission"][i]["commission"]).round()}")
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
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
