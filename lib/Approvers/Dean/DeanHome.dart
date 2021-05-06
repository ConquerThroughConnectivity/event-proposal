import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eventproposal/Approvers/Dean/DeanAccepted.dart';
import 'package:eventproposal/Approvers/Dean/DeanPending.dart';
import 'package:eventproposal/Approvers/Dean/DeanRejected.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueApprover.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueApproverRejected.dart';

import 'package:eventproposal/Controllers/ApproverController.dart';
import 'package:eventproposal/Login/login.dart';
import 'package:eventproposal/utilities/calendar.dart';
import 'package:eventproposal/utilities/globalevents.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class DeanHome extends StatefulWidget {
  final approver;
  final dropdownvalue;
  final orgtype;
  final orgname;
  final organizationType;
  final firstname;
  final middlename;
  final lastname;
  const DeanHome({Key key, this.dropdownvalue, this.orgname, this.orgtype, this.approver, this.organizationType, this.firstname, this.middlename, this.lastname}) : super(key: key);
  @override
  _HomeApproverState createState() => _HomeApproverState();
}

class _HomeApproverState extends State<DeanHome> {
  var activeIndex =0;
  void _onTap(int index) {
    setState((){
      activeIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(widget.dropdownvalue);
    print(widget.orgname);
    print(widget.orgtype);
    print("Dean Home");
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(icon: Icon(EvaIcons.calendar),
            onPressed: (){
              Get.to(()=>SaoCalendar());
            },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                return Alert(
                  context: context,
                  type: AlertType.info,
                  title: "Are you sure you want to logout?",
                  buttons: [
                    DialogButton(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Mops'),
                      ),
                      onPressed: () async {
                        Get.to(()=>Login());
                      },
                      color: Color(0xFFFF3345),
                    ),
                  ],
                  closeFunction: () => null,
                ).show();
              },
            )
          ],
          elevation: 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: GetBuilder<ApproverController>(
            init: ApproverController(),
            builder: (snapshot){
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
              Text(snapshot.fullname.value ??"", style: TextStyle(fontSize: 12),),
              Text(snapshot.fullDepartment.value ??"", style: TextStyle(fontSize: 12),),
              Text(widget.orgname ??widget.orgtype ?? widget.orgname, style: TextStyle(fontSize: 12),),
            ],);
          },),
          ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 70,
          inactiveColor: Colors.white,
          activeColor: Colors.red,
          backgroundColor: Colors.black,
          splashSpeedInMilliseconds: 300,
          splashColor: Colors.red,
          splashRadius: 2.5,
          activeIndex:activeIndex,
          gapLocation: GapLocation.center,
          leftCornerRadius: 30,
          rightCornerRadius: 30, 
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: _onTap,
          icons: [
            EvaIcons.bookOpen,
            EvaIcons.bookmarkOutline,
            EvaIcons.trash,
            EvaIcons.activity
          ],
          
          ),
          
          body: activeIndex ==0 ?DeanPending (approver: widget.orgname ,dropdownValue: widget.dropdownvalue, organization: widget.organizationType)
          :activeIndex ==1 ?DeanAccepted(approver: widget.orgname ,dropdownValue: widget.dropdownvalue,organization: widget.organizationType)
          :activeIndex ==2?DeanRejected(approver: widget.orgname ,dropdownValue: widget.dropdownvalue,organization: widget.organizationType):
          activeIndex ==3?TodayEvents():Container()
    );
  }
}