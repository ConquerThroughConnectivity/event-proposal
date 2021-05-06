import 'package:eventproposal/Approvers/Dean/DeanHome.dart';
import 'package:eventproposal/Approvers/OrganizationApprover/OrganizationApproverHome.dart';
import 'package:eventproposal/Approvers/Venue/VenueHome.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueHomeApprover.dart';
import 'package:eventproposal/Main/mainscreen.dart';
import 'package:eventproposal/Sao/Sao.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class LoginContrller extends GetxController {
  RxString val = ''.obs;
  RxString oRgtype = ''.obs;
  RxString oRgname = ''.obs;
  RxString approvername = ''.obs;
  RxString commitee_incharge = ''.obs;
  bool isDean =false;
  List<String> dropdown = [
    "Select Login Type",
    "Organization Account",
    "Student Affairs Office Account",
    "Organization Approvers Account",
    "Venue Account",
    "Organization Dean",
    "Venue Approver Account"
  ];
  RxBool islogin = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxString getData(String value) {
    val = value.obs;
    return val;
  }

  toFalse() {
    islogin = false.obs;
    update();
  }

  toTrue() {
    islogin = true.obs;
    update();
  }

  login(String dropdownvalue, String schooldID, String password) async {
    toTrue();
    if (dropdownvalue.contains("Organization Account")) {
      dropdownvalue = "Organization";
    } else if (dropdownvalue.contains("Student Affairs Office Account")) {
      dropdownvalue = "Sao";
    } else if (dropdownvalue.contains("Organization Approvers Account")) {
      dropdownvalue = "Approver";
    } else if (dropdownvalue.contains("Venue Account")) {
      dropdownvalue = "Venue";
    } else if (dropdownvalue.contains("Organization Dean")) {
      dropdownvalue = "Approver";
      isDean =true;
    } else if (dropdownvalue.contains("Venue Approver Account")) {
      dropdownvalue = "VenueApprovers";
    } else {
      dropdownvalue = "Select";
    }
    FirebaseDatabase.instance
        .reference()
        .child("User")
        .child(dropdownvalue)
        .orderByChild("id")
        .equalTo(schooldID)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      if (values == null) {
        toFalse();
        print("No account existed");
      } else {
        values.forEach((key, values) {
          if (values["id"] == schooldID && values["password"] == password) {
            toFalse();
          
              // oRgname = value["org_name"].toString().obs;
              // oRgtype = value["org_type"].toString().obs;
              // approvername = value['approver_name'].toString().obs;
              // commitee_incharge = value['committee_in_charge'].toString().obs;
              // update();
             
            if (dropdownvalue.contains("Organization")) {
              toFalse();
              Get.to(() => MainScreen(
                    id: values["id"].toString(),
                    dropdownvalue: dropdownvalue,
                  ));
            } else if (dropdownvalue.contains("VenueApprovers")) {
              toFalse();
              Get.to(()=>VenueHomeApprover(id: values["id"].toString(), dropdownvalue: dropdownvalue, 
              orgtype: values["org_type"], 
              approvername: values["approver_name"],
              firstname:values["firstname"] ,
              middlename: values["middlename"],
              lastname: values["lastname"] ,
              ));
             
            } else if (isDean ==true) {
              toFalse();
              Get.to(() => DeanHome(
                  dropdownvalue: dropdownvalue,
                    organizationType:values["organization_type"] ,
                    orgname:values["org_name"] ,
                    orgtype: values["org_type"],
                    firstname:values["firstname"] ,
                    middlename: values["middlename"],
                    lastname: values["lastname"] ,
                  
                  ));
            } else if (dropdownvalue.contains("Venue")) {
              toFalse();
              if (oRgtype.value != null) {
                Get.to(() => VenueHome(
                    id: values["id"].toString(),
                    dropdownvalue: dropdownvalue,
                    orgtype: values["org_type"],
                    firstname:values["firstname"] ,
                    middlename: values["middlename"],
                    lastname: values["lastname"] ,
                    ));
              }
            }else if(dropdownvalue.contains("Approver")){
              toFalse();
                Get.to(() =>OrganizationApproverHome(
                  dropdownvalue: dropdownvalue,
                    organizationType:values["organization_type"] ,
                    orgname:values["org_name"] ,
                    orgtype: values["org_type"],
                    firstname:values["firstname"] ,
                    middlename: values["middlename"],
                    lastname: values["lastname"] ,
                ));
            }
            else if(dropdownvalue.contains("Sao")){
              toFalse();
                Get.to(() =>SaoHome(
                    lastname: values["lastname"] 
                ));
            }
            print("Success");
        
          } else {
            toFalse();
            print("Failed");
          }
        });
      }
    });
  }

 
}
