import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class CreateEvents extends GetxController {
  RxList<String> venue = [
    "TYK Study Area",
    "UE Open Field",
    "TYK Lobby",
    "Gazebo",
    "MMR 3A",
    "MMR 3B",
    "Computer Laboratories",
    "MPH1",
    "MPH2",
    "MPH3",
    "Briefing Room"
  ].obs;
  RxBool isNothing =false.obs;
  RxInt numberAtendees =0.obs;
  RxList<String> changevenue =[""].obs;
  RxString venueString = "".obs;
  RxString approver = "".obs;
  RxString incharge = "".obs;
  RxString timeFrom = "".obs;
  RxString timeUntil = "".obs;
  RxString date = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  updateVenue(String value) {
    venueString = value.obs;
    update();
  }
  getValueOnchange(int value){
    numberAtendees =value.obs;
  }

  getChanges(int changes){
     changevenue.clear();
    if(changes == 500 ){
      isNothing =true.obs;
      changevenue.add("MPH3");
      update();
     
    }else if(changes == 40){
       isNothing =true.obs;
      changevenue.add("MPH2");
      changevenue.add("MMR 3A");
      changevenue.add("MMR 3B");
      changevenue.add("Computer Laboratories");
        update();
    }else if(changes ==200){
       isNothing =true.obs;
      changevenue.add("MPH1");
        update();
    }
    else if(changes ==50){
      isNothing =true.obs;
      changevenue.add("Briefing Room");
      update();
    }else{
      isNothing =false.obs;
      update();
    }
 
    
  }

  getInchargeApprover(String value) {
    if (value.contains('TYK Study Area') ||
        value.contains('UE Open Field') ||
        value.contains('TYK Lobby') ||
        value.contains('Gazebo')) {
      incharge = "ESO".obs;
      approver = "Chancellor".obs;
      update();
    } else if (value.contains('MMR 3A') ||
        value.contains('MMR 3B') ||
        value.contains('Computer Laboratories')) {
      incharge = "Information Technology".obs;
      approver = "Chancellor".obs;
      update();
    } else if (value.contains('MPH1') || value.contains('MPH2')) {
      incharge = "Library Head".obs;
      approver = "Assistant Director".obs;
      update();
    }
  }

  getTimeFrom(String timefrom) {
    timeFrom = timefrom.obs;
    update();
  }

  getTimeUntil(String timeuntil) {
    timeUntil = timeuntil.obs;
    update();
  }

  getDate(String dateevent) {
    date = dateevent.obs;
    update();
  }

  createEvent(
    String id,
    String orgname,
    String orgtype,
    RxString dateofEvent,
    TextEditingController nameofTheProject,
    TextEditingController natureofTheProject,
    RxString venues,
    RxString timeTo,
    RxString timeuntils,
    RxString inCharges,
    RxString approVers,
    TextEditingController beneficiaries,
    TextEditingController description,
    TextEditingController generaldescription,
    TextEditingController specificdescription,
    TextEditingController planningstage,
    TextEditingController implementation,
    TextEditingController resourcerequirement,
    TextEditingController evaluation,
  ) {
    FirebaseDatabase.instance
        .reference()
        .child("Venue")
        .child("VenueReservation")
        .orderByChild("id")
        .equalTo(id)
        .once()
        .then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = await snapshot.value;
      if (values == null) {
      } else {
        int isCreate =0;
        values.forEach((key, values) {
          if (values != null) {
            if (venues.value.toString().isEmpty ||
                timeTo.value.toString().isEmpty ||
                timeUntil.value.toString().isEmpty ||
                dateofEvent.value.toString().isEmpty) {
              isCreate =1;
              print(isCreate);
              print("Other fields are empty please fill them up");
            } else {
              if (dateofEvent.value
                  .toString()
                  .contains(values['date_of_event'])) {
                isCreate=2;
                print(isCreate);
                print("You already Propose on this date");
              } else {
                isCreate =3;
              }
            }
          } else {}
        });
        if (isCreate ==3) {
          print("Success");
          FirebaseDatabase.instance
              .reference()
              .child("Venue")
              .child("VenueReservation")
              .push()
              .set({
            'name_of_project': nameofTheProject.text,
            'nature_of_project': natureofTheProject.text,
            'venue': venues.value.toString(),
            'committee_in_charge': inCharges.value.toString(),
            'time_to': timeTo.value.toString(),
            'time_from': timeuntils.value.toString(),
            'approver_name': approVers.value.toString(),
            'beneficiaries': beneficiaries.text,
            'name_incharge': 'Nothing yet',
            'name_approver': 'Nothing yet',
            'date': dateofEvent.toString(),
            'incharge': "Pending",
            'org_president': "Nothing Yet",
            'org_president_status': "Pending",
            'org_adviser': "Nothing Yet",
            'org_adviser_status': "Pending",
            'org_dean': "Nothing Yet",
            'org_dean_status': "Pending",
            'approver': "Pending",
            'status': "Pending",
            'id': id.toString(),
            'org_type': orgtype.toString(),
            'org_name': orgname.toString(),
            'date_of_event': dateofEvent.toString(),
            'description': description.text,
            'general_objective': generaldescription.text,
            'specific_objective': specificdescription.text,
            'planning_statge': planningstage.text,
            'implementation': implementation.text,
            'resource_req': resourcerequirement.text,
            'evaluation': evaluation.text,
            'disapproval_reason':"",
          });
        }
      }
    });
  }
}
