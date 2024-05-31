// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:referral_app/login.dart';

import '../controllers/getcontroller.dart';

// import '../controller/getcontrollers.dart';

class Service {
  GlobleVar controller = Get.find();

  gettoken() async {
    print("working");

    final response = await http.get(
      Uri.parse('${controller.uri}/api/loanReferal/Token/CreateGeneralToken'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      controller.token = temp["data"]["authToken"];

      return temp;
    } else if (response.statusCode == 400) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception("something went worng");
    }
  }

  login(String logintext, password) async {
    debugPrint("working login");
    debugPrint("loginUserId: $logintext");

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/Login?email=$logintext&password=$password'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      controller.logindetails = temp["data"]["referer"];
      controller.referdoc = temp["data"]["refererDoc"];
      controller.corporatedetails = temp["data"]["refererCorporate"];
      if(controller.corporatedetails.length!=0){
        controller.corporateid=controller.corporatedetails[0]["corporateDetailsId"];
        debugPrint("controller.corporateid  ${controller.corporateid}");
      }
      debugPrint(controller.logindetails.toString());
      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  getcorporatedetails() async {
    debugPrint("working getcorporatedatails");
    //debugPrint("emailId: $emailId");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Corporate/GetActiveCorporate'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  getcorporatecatalog(corporateId) async {
    debugPrint("working getcorporatecatalog");
    //debugPrint("emailId: $emailId");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Corporate/GetLoanTypeAndCommission?corporateId=$corporateId'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  signUp(firstname, lastname, emailid, dob, pannumber, phnno, password,
      corporateDetails) async {
    debugPrint("working SignUp");
    jsonbody() {
      return json.encode({
        "id": 0,
        "refererId": 0,
        "firstName": firstname,
        "lastName": lastname,
        "emailId": emailid,
        "dateOfBirth": dob,
        "panNumber": pannumber,
        "password": password,
        "mobileNumber": phnno,
        //"BankName": "",
        //"accountHolderName": "",
        // "accountNumber": "",
        // "ifscCode": "",
        //"ProfilePicUrl":"",
        //"NoteDetails":"",
        "Status": "Submited",
        "corporateDetails": corporateDetails
      });
    }

    debugPrint(jsonbody().toString());

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/InsertOrUpdateReferelDet'),
      body: jsonbody(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    debugPrint(response.statusCode.toString());
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      //debugPrint(jsonDecode(response.body));
      print("Signup ${response.body}");
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      print("Signup ${response.body}");
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  getemailIdOtp(String emailId) async {
    debugPrint("working getemailIdotp");
    debugPrint("emailId: $emailId");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/forgotEmailOtp?emailId=$emailId&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  verifyemailIdOtp(String emailId, otp) async {
    debugPrint("working verifyemailIdotp");
    debugPrint("emailId: $emailId   ...  $otp");

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/VerifyEmailOtp?email=$emailId&otp=$otp&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  changepassword(String emailId, password) async {
    debugPrint("working changepassword");
    debugPrint("emailId: $emailId   ...  $password");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/ChangePassword?emailId=$emailId&password=$password&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      return temp;
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  updatebankdetails(firstname, lastname, emailid, dob, phnno, pannumber,
      bankname, accountholdername, accountnumber, ifsccode, profilepic) async {
    debugPrint("working SignUp");
    jsonbody() {
      return json.encode({
        "id": controller.logindetails["id"],
        //"refererId": refid,
        "firstName": firstname,
        "lastName": lastname,
        "emailId": emailid,
        "dateOfBirth": dob,
        "panNumber": pannumber,
        "mobileNumber": phnno,
        "BankName": bankname,
        "accountHolderName": accountholdername,
        "accountNumber": accountnumber,
        "ifscCode": ifsccode,
        "ProfilePicUrl": profilepic,
        "corporateDetailsId": controller.corporateid
      });
    }

    debugPrint(jsonbody());

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/InsertOrUpdateReferelDet'),
      body: jsonbody(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      //debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  updateprofilepic(firstname, lastname, emailid, dob, phnno, pannumber,
      profilepic, bankname, accountholdername, accountnumber, ifsccode) async {
    debugPrint("working updateprofilepic");
    jsonbody() {
      return json.encode({
        "id": controller.logindetails["id"],
        //"refererId": refid,
        "firstName": firstname,
        "lastName": lastname,
        "emailId": emailid,
        "dateOfBirth": dob,
        "panNumber": pannumber,
        "mobileNumber": phnno,
        "ProfilePicUrl": profilepic,
        "BankName": bankname,
        "accountHolderName": accountholdername,
        "accountNumber": accountnumber,
        "ifscCode": ifsccode,
        "corporateDetailsId": controller.corporateid
      });
    }

    debugPrint(jsonbody());

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/InsertOrUpdateReferelDet'),
      body: jsonbody(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      //debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  updatedocuments(sendlist) async {
    debugPrint("working updateprofilepic");

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Registration/InsertOrUpdateDocuments'),
      body: json.encode(sendlist),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      //debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  leadscount() async {
    debugPrint("working test");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Leads/LeadsCountByStatus?refereId=${controller.logindetails["id"]}&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  leadsdetailsbyrefid(statusid) async {
    debugPrint("working test");
    debugPrint(
        "refererId ..${controller.logindetails["id"]}   ...statusid $statusid");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Leads/LeadsDetailsByrefereId?leadsRefererId=${controller.logindetails["id"]}&LeadsStatusMasterId=$statusid&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  newleads() async {
    debugPrint("working SignUp");
    jsonbody() {
      return {
        "id": 0,
        "refererDetailsId": controller.logindetails["id"],
        "applicantFirstName": controller.newleadmap["firstname"] ?? "",
        "applicantLastName": controller.newleadmap["lastname"] ?? "",
        "mobileNumber": controller.newleadmap["mobileno"] ?? "",
        "emailId": controller.newleadmap["emailid"] ?? "",
        "dateOfBirth": controller.newleadmap["dob"][1] ?? "",
        "maritalStatus": controller.newleadmap["maritalstatus"] ?? "",
        "gender": controller.newleadmap["gender"] ?? "",
        "residentialType": controller.newleadmap["residentialtype"] ?? "",
        "address": controller.newleadmap["address"] ?? "",
        "countryCode": controller.newleadmap["country"] ?? "",
        "countryName": controller.newleadmap["country"] ?? "",
        "stateCode": controller.newleadmap["state"] ?? "",
        "stateName": controller.newleadmap["state"] ?? "",
        "cityCode": controller.newleadmap["city"] ?? "",
        "cityName": controller.newleadmap["city"] ?? "",
        "pincode": controller.newleadmap["pincode"] ?? "",
        "organizationType": controller.newleadmap["organization"] ?? "",
        "organizationName":
            controller.newleadmap["nameoftheorganization"] ?? "",
        "annualIncome": int.parse(controller.newleadmap["annuualincome"] ?? 0),
        "panNumber": controller.newleadmap["pannumber"] ?? "",
        "loanTypeMasterId": 1, // controller.newleadmap["loantype"] ?? 0,
        "expectedLoanAmount": controller.newleadmap["expectedloanamount"] ?? 0,
        "loanPurpose": controller.newleadmap["loanpurpose"] ?? "",
        "leadsStatusMasterId": 1, // controller.newleadmap["firstname"] ?? 0,
        "lastUpdatedDate": "2024-03-26T11:17:00.970Z",
        "lastUpdatedBy": 0,
        "corporateDetailsId": controller.corporateid
      };
    }

    debugPrint(json.encode(jsonbody()));

    final response = await http.post(
      Uri.parse(
          '${controller.uri}/api/loanReferal/Leads/InsrtOrUpdateLeadsServices'),
      body: json.encode(jsonbody()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      //debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      // debugPrint(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  getpayouts() async {
    debugPrint("working test");
    debugPrint(
        "refererId ..${controller.logindetails["id"]}  corporateDetailsId  ..${controller.corporateid} ");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/ReferrerPayout/GetRefererPayoutForMobileApp?refererDetailsId=${controller.logindetails["id"]}&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  uploadsignedinvoice(payoutid, docpath) async {
    debugPrint("working test");
    debugPrint(
        "refererId ..${controller.logindetails["id"]} ..payoutid  $payoutid    docpath  $docpath corporateDetailsId  ..${controller.corporateid} ");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/ReferrerPayout/UpdateSignedInvoiceDetails?refPayoutId=$payoutid&signedInvoiceUrl=$docpath&userId=${controller.logindetails["id"]}&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  getpayouttransation() async {
    debugPrint("working test");
    debugPrint(
        "refererId ..${controller.logindetails["id"]}  corporateDetailsId  ..${controller.corporateid} ");

    final response = await http.get(
      Uri.parse(
          '${controller.uri}/api/loanReferal/ReferrerPayout/GetTransactionsforReferer?refererDetailsId=${controller.logindetails["id"]}&corporateDetailsId=${controller.corporateid}'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": controller.token
      },
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      unautheredpopup();
    } else {
      throw Exception("something went worng");
    }
  }

  uploadFile(String filepath, var type) async {
    print('llwlwlwwleeeelweed3e3drrrrrrrrrrrrrrrrr');
    print("uploadFile ${controller.logindetails["id"]}  z$type   ");
    Map<String, String> headers = {"token": controller.token};
    var request = http.MultipartRequest('POST',
        Uri.parse("${controller.uri}/api/loanReferal/Registration/fileupload"))
      ..fields["userId"] = controller.logindetails["id"].toString()
      ..headers.addAll(headers)
      ..files.add(http.MultipartFile('image',
          File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
          filename: filepath.split("/").last));
    var streamedResponse = await request.send();
    print('llwlwlwwleeeelweed3e3d');
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    print(result);
    if (response.statusCode == 401) {
      unautheredpopup();
    }
    return result;
  }

  unautheredpopup() {
    return Get.dialog(
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          var size = MediaQuery.of(context).size;
          var height = size.height;
          var width = size.width;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: width - 40,
                height: height * 0.17,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Seccetion Expered please re-login",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.offAll(() => const Login());
                              },
                              child: const Text("ok"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Service server = Service();
