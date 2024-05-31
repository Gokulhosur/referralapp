// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';

class GlobleVar extends GetxController {
  String uri = "http://referalappapi.sysmedac.com";

  var logindetails;
  var referdoc;
  String token = "";

  var corporateid;
  List corporatedetails = [];

  var newleadmap = {};
}
