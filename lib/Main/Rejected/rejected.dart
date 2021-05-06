import 'package:eventproposal/utilities/card.dart';
import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:eventproposal/Controllers/organization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class OrganizationRejected extends StatelessWidget {
  final id;
final dropdownvalue;
  const OrganizationRejected({Key key, this.id, this.dropdownvalue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Organization>(
        init: Organization(),
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
                'Rejected Proposal',
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            ),
            GetBuilder<Organization>(
              init: Organization(),
              builder: (snapshot){
              return Container(
              alignment: Alignment.center,
             
             
              child: StreamBuilder(
                stream: snapshot.getSaoPrososal(this.id),
                builder: (BuildContext context, AsyncSnapshot<Event> snapshots){
                  if(snapshots.hasData){
                      int count =0;
                      Map<dynamic, dynamic> values =snapshots.data.snapshot.value;
                      if(values!=null){
                       
                        values.forEach((key, value){
                          if(value["status"].toString().contains("Rejected") ==null || value["status"].toString().contains("Rejected") ){
                            count++;
                          }else{
                            print("okay");
                          }
                        });  
                       
                        
                       
                          return Stack(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(top: 20),
                                child: Text('Total Rejected Proposals: $count', style: TextStyle(fontSize: 15, fontFamily: "Mops"),)),
                              Container(
                                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                                  child: ListView.builder(
                                  itemCount:values.values.toList().length ,
                                  itemBuilder: (context, index){
                                 
                                  if(values.values.toList()[index]["status"].toString().contains("Rejected")){
                                    
                                     return Stack(
                                       children: [
                                        
                                         SizedBox(height: 30,),
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
                                            CardForm(text: "Beneficiaries: "+" "+values.values.toList()[index]['beneficiaries'],),
                                            CardForm(text: "Type: "+" "+values.values.toList()[index]['org_type'],),
                                            CardForm(text: "Name: "+" "+values.values.toList()[index]['org_name'],),
                      
                  
                                            CardForm(text: "General Objectives: "+" "+values.values.toList()[index]['general_objective'],),
                                            CardForm(text: "Specific Objectives: "+" "+values.values.toList()[index]['specific_objective'],),
                                            CardForm(text: "Planning Stage: "+" "+values.values.toList()[index]['planning_statge'],),
                                            CardForm(text: "Implementation: "+" "+values.values.toList()[index]['implementation'],),
                                            CardForm(text: "Resource Requirement: "+" "+values.values.toList()[index]['resource_req'],),
                                            CardForm(text: "Evaluation: "+" "+values.values.toList()[index]['evaluation'],),
                                            
                                            ],
                                          title:Text("Name Of The Project: "+" "+values.values.toList()[index]['name_of_project'], style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Mops",
                                          fontSize: 15)),),
                                        ),
                                        
                                       ],);
                                  }
                                  return Container();
                         
                        },),
                                ),
                            ],
                          );
                        
                        
                      }
                    }else{
                      return Text('No Rejected Proposal yet');
                    }
                    return Container();
                }),
            );
              },)
          ],)
          );
        } ,),
    );
  }
}