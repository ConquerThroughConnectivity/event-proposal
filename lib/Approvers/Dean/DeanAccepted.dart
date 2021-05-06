import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:eventproposal/Controllers/ApproverController.dart';
import 'package:eventproposal/utilities/card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
class DeanAccepted extends StatelessWidget {
  final approver;
  final dropdownValue;
  final orgtype;
  final orgname;
  final String organization;
  final fullname;
  const DeanAccepted ({Key key, this.approver, this.dropdownValue, this.orgtype, this.orgname, this.organization, this.fullname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ApproverController>(
        init: ApproverController(),
        builder:(snapshot){
        
        return CustomRefreshIndicator(
          builder:( BuildContext context, Widget child, IndicatorController controller){
            return AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _){
                return Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    if(!controller.isIdle)
                    Positioned(
                      top: 35.0 * controller.value,
                      child: SizedBox(
                        height: 85,
                        width: 85,
                        child: Transform.rotate(
                          child: Image.asset('lib/assets/logo.png', scale: 10,),
                          angle: controller.value * 2 *math.pi,),
                      ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 100 *controller.value),
                        child: child,
                      ),
                  ],
                );
              } ,
            );
          }, 
          onRefresh: snapshot.test,
          child: Stack(
            children: [
            Container(
              margin: EdgeInsets.only(bottom: 500),
              child: Center(
                  child: Text(
                'Accepted Proposals',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ),
            GetBuilder<ApproverController>(
              init: ApproverController(),
              builder: (snapshots){
              return Container(
              alignment: Alignment.center,

              child: StreamBuilder(
                stream:FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").orderByChild('org_type').equalTo("${this.organization}").onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snapshot){
                  if(snapshot.hasData){
                      
                      Map<dynamic, dynamic> values =snapshot.data.snapshot.value;
                      if(values!=null){
                        int count =0;
                        values.forEach((key, value){
                          if(value["org_dean_status"].toString().contains("Accepted") && value["org_president_status"].toString().contains("Accepted")
                          && value["org_adviser_status"].toString().contains("Accepted")){
                            count++;
                          }else{
                            print("okay");
                          }
                        });  
                        
                          return Stack(children: [
                            Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 20),
                                child: Text('Total Accepted Proposals: $count', style: TextStyle(fontSize: 15, fontFamily: "Mops"),)),
                            Container(
                            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                            child: ListView.builder(
                            itemCount:values.values.toList().length ,
                            itemBuilder: (context, index){
                            if(values.values.toList()[index]['org_president_status'].toString().contains("Accepted") &&
                                values.values.toList()[index]['org_adviser_status'].toString().contains("Accepted") && 
                                values.values.toList()[index]['org_dean_status'].toString().contains("Accepted")){
                               return Slidable(
                                 actionPane:SlidableDrawerActionPane(),
                                 actionExtentRatio: 0.25,
                                 showAllActionsThreshold: 0.5,
                                 actions: [
                                  //  IconSlideAction(
                                  //   caption: 'Accept',
                                  //   color: Colors.blue,
                                  //   icon: Icons.send,
                                  //   onTap: (){
                                  //     FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                  //     "approver": ""+"Accepted",
                                  //     "name_approver": this.approver,
                                  //     }).then((onValue){

                                  //     });
                                  //   },
                                  // ),
                                  // IconSlideAction(
                                  //   caption: 'Reject',
                                  //   color: Colors.redAccent,
                                  //   icon: Icons.remove_circle_outline_rounded,
                                  //   onTap: (){
                                  //     FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                  //     "approver": ""+"Rejected",
                                  //     "name_approver": this.approver,
                                  //     }).then((onValue){

                                  //     });
                                  //   },
                                  // ),
                                  
                                  
                                 ],
                                 child: Stack(
                                   children: [
                                    Card(
                                      color: Colors.red,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: ExpansionTile(
                                        children: [
                                          CardForm(text: "Nature Of The Project: "+" "+values.values.toList()[index]['nature_of_project'],),
                                          CardForm(text: "Committee In Charge: "+" "+values.values.toList()[index]['committee_in_charge'],),
                                          Card(
                                          color: Colors.white,
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0)),
                                            child: ListTile(
                                            leading: Icon(Icons.place, color: Colors.black,),
                                            title: Text("Venue: "+" "+values.values.toList()[index]['venue'], style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Mops",
                                              fontSize:15
                                              )),
                                            trailing: Text("Date: "+" "+values.values.toList()[index]['date_of_event'], style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Mops",
                                              fontSize: 15
                                              )),
                                          ),
                                          
                                        ),
                                        CardForm(text: "Date of Request: "+" "+values.values.toList()[index]['date'],),
                                        CardForm(text: "Description: "+" "+values.values.toList()[index]['description'],),
                                        Card(
                                          color: Colors.white,
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4.0)),
                                            child: ListTile(
                                            leading: Icon(Icons.av_timer, color: Colors.black,),
                                            title: Text("Time Start: "+" "+values.values.toList()[index]['time_from'], style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Mops",
                                              fontSize: 15)),
                                            trailing: Text("Time End: "+" "+values.values.toList()[index]['time_to'], style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Mops",
                                              fontSize: 15)),

                                          ),
                                        ),
                                        CardForm(text: "Beneficiaries: "+" "+values.values.toList()[index]['beneficiaries']?? "",),
                                        CardForm(text: "Type: "+" "+values.values.toList()[index]['org_type']?? "",),
                                        CardForm(text: "Name: "+" "+values.values.toList()[index]['org_name']?? "",),
                                        CardForm(text: "Approver: "+" "+values.values.toList()[index]['approver_name']?? "",),
                                        CardForm(text: "In-Charge Validation: "+" "+values.values.toList()[index]['incharge']?? "",),
                                        CardForm(text: "Approver Validation: "+" "+values.values.toList()[index]['approver']?? "",),
                                        CardForm(text: "In Charge Name: "+" "+values.values.toList()[index]['name_incharge']?? "",),
                                        CardForm(text: "Approver Name: "+" "+values.values.toList()[index]['name_approver']?? "",),
                                        CardForm(text: "General Objectives: "+" "+values.values.toList()[index]['general_objective']?? "",),
                                        CardForm(text: "Specific Objectives: "+" "+values.values.toList()[index]['specific_objective']?? "",),
                                        CardForm(text: "Planning Stage: "+" "+values.values.toList()[index]['planning_statge']?? "",),
                                        CardForm(text: "Implementation: "+" "+values.values.toList()[index]['implementation']?? "",),
                                        CardForm(text: "Resource Requirement: "+" "+values.values.toList()[index]['resource_req']?? "",),
                                        CardForm(text: "Evaluation: "+" "+values.values.toList()[index]['evaluation']?? "",),
                                        CardForm(text: "Organization President: "+" "+values.values.toList()[index]['org_president']?? "",),
                                        CardForm(text: "Organization President Status: "+" "+values.values.toList()[index]['org_president_status']?? "",),
                                        CardForm(text: "Organization Adviser: "+" "+values.values.toList()[index]['org_adviser']?? "",),
                                        CardForm(text: "Organization Adviser Status: "+" "+values.values.toList()[index]['org_adviser_status']?? "",),
                                        CardForm(text: "Organization Dean: "+" "+(( values.values.toList()[index]['org_dean'] ?? "")),),
                                        CardForm(text: "Organization Dean Status: "+" "+((values.values.toList()[index]['org_dean_status'] ?? "")),),
                                        ],
                                      title:Text("Name Of The Project: "+" "+values.values.toList()[index]['name_of_project'], style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Mops",
                                      fontSize: 15)),),
                                    ),
                                    
                                   ],),
                               );
                            }
                            return Container();
                         
                        },),
                          ),
                          ],);
                        
                        
                      }
                    }else{
                      return Text('No Proposal yet');
                    }
                    return Container();
                }),
            );
              },)
          ],)
          );
        } ,)
    );
  }
}