import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Organization extends GetxController {
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

  count() {
    iscount++;
    update();
  }

  Future<Null> test() async {
    await Future.delayed(Duration(seconds: 4));
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
          con = value['org_type'] + "  " + value['org_name'];
          fullDepartment = con.obs;
          orgname = value["org_name"];
          orgyName = orgname.obs;
          orgtype = value["org_type"];
          orgyType = orgtype.obs;
        });
      }
    });
  }

  getEventPending(String id) {
    return FirebaseDatabase.instance
        .reference()
        .child("Venue")
        .child("VenueReservation")
        .orderByChild('id')
        .equalTo(id)
        .onValue;
  }

  getSaoPrososal(String id) {
    return FirebaseDatabase.instance
        .reference()
        .child("SAO")
        .child("Proposal")
        .orderByChild("id")
        .equalTo(id)
        .onValue;
  }

  proposeToSao(Map<dynamic, dynamic> values, int index, String id,String fullname, String orgtype, String orgname, BuildContext context) async{
    int c= 0;
    FirebaseDatabase.instance.reference().child("SAO").child("Proposal").orderByChild("id").equalTo(id).once().then((DataSnapshot snapshot)async{
      Map<dynamic, dynamic> datavalue =await snapshot.value;
      datavalue.forEach((key, data){
      if(data['date_of_event'].toString().contains(values.values.toList()[index]['date_of_event'].toString()) && 
      data['time_from'].toString().contains(values.values.toList()[index]['time_from'].toString()) &&
      data['time_to'].toString().contains( values.values.toList()[index]['time_to'].toString()) &&
      data['venue'].toString().contains(values.values.toList()[index]['venue'].toString())){
      c =1;
    }
       });
      if(c==1){
        showInfoFlushbar(context, "Already Propose to SAO", Icons.info_outline);
      }else{
        if (values.values
            .toList()[index]['org_dean_status']
            .toString()
            .contains('Pending') !=
        null) {
      if (values.values
          .toList()[index]['org_dean_status']
          .toString()
          .contains('Pending')) {
        showInfoFlushbar(context, "Cannot Propose to SAO Pending Organization Dean Status", Icons.info_outline);
      } else if (values.values
          .toList()[index]['org_dean_status']
          .toString()
          .contains('Denied')) {
        showInfoFlushbar(context, "Cannot Propose to SAO Denied Organization Dean Status", Icons.info_outline);
      } else if (values.values
          .toList()[index]['org_dean_status']
          .toString()
          .contains('Accepted')) {
        saoPropose(id, index, values, fullname, orgtype, orgname);             
        showInfoFlushbar(context, "Success wait for Approval Status", Icons.check);
      }
    } else {
      if (values.values
          .toList()[index]['org_adviser_status']
          .toString()
          .contains('Pending')) {
        showInfoFlushbar(context, "Cannot Propose to SAO Pending Organization Adviser Status", Icons.info_outline);
      } else if (values.values
          .toList()[index]['org_adviser_status']
          .toString()
          .contains('Denied')) {
        showInfoFlushbar(context, "Cannot Propose to SAO Rejected Organization Adviser Status", Icons.info_outline);
      } else if (values.values
          .toList()[index]['org_adviser_status']
          .toString()
          .contains('Accepted')) {
         saoPropose(id, index, values, fullname, orgtype, orgname);   
        showInfoFlushbar(context, "Success wait for Approval Status", Icons.check);
      }
    }
      }
      
    
     
    });
    
    
  }

  saoPropose(String id, int index, Map<dynamic, dynamic> values, String fullname, String orgtype, String orgname) {
    FirebaseDatabase.instance.reference().child("SAO").child("Proposal").orderByChild("id").equalTo(id).once().then((DataSnapshot snapshot)async{
      Map<dynamic, dynamic> values =await snapshot.value;
      values.forEach((key, data){
        
         FirebaseDatabase.instance
        .reference()
        .child("SAO")
        .child("Proposal")
        .push()
        .set({
      "name_of_project": values.values.toList()[index]['name_of_project'],
      "nature_of_project":
          "" + values.values.toList()[index]['nature_of_project'],
      "committee_in_charge": values.values.toList()[index]
          ['committee_in_charge'],
      "venue": values.values.toList()[index]['venue'],
      "time_from": values.values.toList()[index]['time_from'],
      "time_to": values.values.toList()[index]['time_to'],
      "beneficiaries": values.values.toList()[index]['beneficiaries'],
      "prepared_by": fullname,
      "noted_by_adviser": values.values.toList()[index]['org_adviser'],
      "noted_by_org_president": values.values.toList()[index]['org_president'],
      "recommending_approval": values.values.toList()[index]['org_dean'],
      "org_type": orgtype,
      "org_name": orgname,
      "date": values.values.toList()[index]['date'],
      "status": "Pending",
      'id': id,
      'date_of_event': values.values.toList()[index]['date_of_event'],
      'description': values.values.toList()[index]['description'],
      'general_objective': values.values.toList()[index]['general_objective'],
      'specific_objective': values.values.toList()[index]['specific_objective'],
      'planning_statge': values.values.toList()[index]['planning_statge'],
      'implementation': values.values.toList()[index]['implementation'],
      'resource_req': values.values.toList()[index]['resource_req'],
      'evaluation': values.values.toList()[index]['evaluation'],
      'disapproval_reason':"",
    }); 
      
      });
      
    });
  }
  showInfoFlushbar(BuildContext context, String message, IconData icon) {
    Flushbar(
      message: message,
      icon: Icon(
        icon,
        size: 28,
        color: Color(0xFF3061cc),
      ),
      leftBarIndicatorColor: Color(0xFF3061cc),
      duration: Duration(seconds: 5),
    )..show(context);
  }
}
