import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApproverController extends GetxController{

  RxString fullname = "".obs;
  RxString fullDepartment = "".obs;
  RxInt iscount = 0.obs;
  RxString orgyName = "".obs;
  RxString orgyType = "".obs;
  @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
    }
   Future<Null> test() async {
    await Future.delayed(Duration(seconds: 4));
  }

  getVenueApprover(String dropdownvalue, String orgname)async{
    return FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").orderByChild('approver_name').equalTo(orgname).onValue;
  }

   getDetails(String id, String orgType) async {
    FirebaseDatabase.instance
        .reference()
        .child("User")
        .child(orgType)
        .orderByChild("id")
        .equalTo(id)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      if (values != null) {
        String concat;
        String con;
        String orgname;
        String orgtype;
        values.forEach((key, value) {
          concat = value['firstname'] +
              " " +
              value['middlename'] +
              " " +
              value['lastname'];
          fullname = concat.obs;
          con = value['org_type'];
          fullDepartment = con.obs;
          orgname = value["org_name"];
          orgyName = orgname.obs;
          orgtype = value["org_type"];
          orgyType = orgtype.obs;
          update();
        });
      }
    });
  }
  void popupInvalid(String message, String warning, BuildContext context) {
    Flushbar(
      title: warning,
      messageText: Text(
        message,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
      ),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeInOutExpo,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Color(0xFFFF3345),
      shouldIconPulse: true,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      isDismissible: true,
      icon: Icon(
        Icons.error,
        size: 30.0,
        color: Color(0xFFFF3345),
      ),
      duration: Duration(seconds: 4),
    )..show(context);
  }

}