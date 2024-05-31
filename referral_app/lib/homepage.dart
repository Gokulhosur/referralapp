import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/myleads.dart';
import 'package:referral_app/screens/payouts/payouts.dart';
import 'package:referral_app/screens/profile/profile.dart';

import 'controllers/getcontroller.dart';
import 'screens/create leads/createlead_page1.dart';
import 'screens/home.dart';

class Homepage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final pageno;
  const Homepage({super.key, required this.pageno});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobleVar controller = Get.find();
  int currentindex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentindex = widget.pageno;
    });
  }

  static const List<Widget> pages = <Widget>[
    Home(),
    Myleads(),
    CreateleadPage1(),
    Payouts(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(15, 50, 160, 1),
          onPressed: () {
            print("Status ${controller.logindetails["status"]}");
            if (controller.logindetails["status"] == "Approve") {
              Get.to(() => const CreateleadPage1());
            } else {
              var snackBar = const SnackBar(
                elevation: 20,
                shape: StadiumBorder(),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(50),
                content: Text(
                  "Can not create Leads before Your Profile is Approved by Admin",
                  textAlign: TextAlign.center,
                ),
              );

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Image.asset("assets/Create Leads.png"),
        ),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            backgroundColor: const Color.fromRGBO(15, 50, 160, 1),
            // iconSize: 20,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentindex,
            onTap: (value) {
              setState(() {
                if (value != 2) {
                  print(controller.logindetails["status"]);

                  currentindex = value;
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/Home Outline.png"),
                activeIcon: Image.asset("assets/Home Fill.png"),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/My Lead Outline.png"),
                activeIcon: Image.asset("assets/My Lead Fill.png"),
                label: "My Leads",
              ),
              const BottomNavigationBarItem(
                icon: SizedBox(), //dummy item for UI alinement
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/Payout Outline.png"),
                activeIcon: Image.asset("assets/Payout Fill.png"),
                label: "Payouts",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/Profile Outline.png"),
                activeIcon: Image.asset("assets/Profile Fill.png"),
                label: "Profile",
              ),
            ],
          ),
          // items: [],
        ),
        body: (pages.elementAt(currentindex)),
      ),
    );
  }
}
