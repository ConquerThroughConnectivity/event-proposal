import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueApprover.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueApproverAccepted.dart';
import 'package:eventproposal/Approvers/VenueApprover/VenueApproverRejected.dart';

import 'package:eventproposal/Controllers/ApproverController.dart';
import 'package:eventproposal/Login/login.dart';
import 'package:eventproposal/utilities/calendar.dart';
import 'package:eventproposal/utilities/globalevents.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



class VenueHomeApprover extends StatefulWidget {
  final dropdownvalue;
  final id;
  final orgname;
  final orgtype;
  final approvername;
  final firstname;
  final middlename;
  final lastname;
  
  const VenueHomeApprover({Key key, this.dropdownvalue, this.id, this.orgname, this.orgtype, this.approvername, this.firstname, this.middlename, this.lastname}) : super(key: key);
  @override
  _HomeApproverState createState() => _HomeApproverState();
}

class _HomeApproverState extends State<VenueHomeApprover> {
  var activeIndex =0;
  void _onTap(int index) {
    setState((){
      activeIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(widget.dropdownvalue);
    print(widget.approvername);
    // print(widget.orgtype);
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
            snapshot.getDetails(widget.id, widget.dropdownvalue);
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
              
              Text("${widget.firstname} ${widget.middlename} ${widget.lastname}", style: TextStyle(fontSize: 12),),
              Text(widget.approvername==null?widget.orgtype:widget.approvername, style: TextStyle(fontSize: 12),),
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
          
          body: activeIndex ==0 ?VenueApproverPending(approver: widget.approvername ,dropdownValue: widget.dropdownvalue, orgtype: widget.orgtype, fullname:"${widget.firstname} ${widget.middlename} ${widget.lastname}" ,)
          :activeIndex ==1 ?VenueApproverAccepted(approver: widget.approvername ,dropdownValue: widget.dropdownvalue,orgtype: widget.orgtype):
          activeIndex ==2 ?VenueApproverRejected(approver: widget.approvername ,dropdownValue: widget.dropdownvalue,orgtype: widget.orgtype):
          activeIndex ==3 ?TodayEvents():Container()
    );
  }
}