import 'package:date_field/date_field.dart';
import 'package:eventproposal/Controllers/CreateEvent.dart';
import 'package:eventproposal/utilities/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class CreateEvent extends StatelessWidget {
  final TextEditingController nameofTheProject = new TextEditingController();
  final TextEditingController natureofTheProject = new TextEditingController();
  final TextEditingController beneficiaries = new TextEditingController();
  final TextEditingController timeFrom = new TextEditingController();
  final TextEditingController timeTo = new TextEditingController();
  final TextEditingController eventDate = new TextEditingController();
  final TextEditingController description = new TextEditingController();

  final TextEditingController generaldescription = new TextEditingController();
  final TextEditingController specificdescription = new TextEditingController();
  final TextEditingController planningstage = new TextEditingController();
  final TextEditingController implementation = new TextEditingController();
  final TextEditingController resourcerequirement = new TextEditingController();
  final TextEditingController evaluation = new TextEditingController();
  final TextEditingController atendees = new TextEditingController();
  final nokey = GlobalKey<FormState>();
  final id;
  final orgname;
  final orgtype;
  CreateEvent({Key key, this.id, this.orgname, this.orgtype}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateEvents>(
      init: CreateEvents(),
      builder: (snapshot) {
        print(orgname);
        print(orgtype);
        return Stack(
          children: [
            Container(
              child: Center(
                child: Form(
                  key: nokey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: atendees,
                          onChanged: (value){
                            snapshot.getValueOnchange(int.parse(value));
                            snapshot.getChanges(int.parse(value));
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                          labelText: "Number of Attendees",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Color(0xFF2d3447))),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.person),
                          
                        ),
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 340,
                        child: Card(
                          elevation: 10,
                          child: DropdownButton<String>(
                            hint: Container(
                                margin: EdgeInsets.all(10),
                                child: snapshot.venueString.value == ""
                                    ? Text('Select Venue')
                                    : Text(snapshot.venueString.value)),
                            underline: SizedBox(),
                            items: snapshot.isNothing.value==true?snapshot.changevenue.map((String string) {
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string),
                              );
                            }).toList() :snapshot.isNothing.value==false?snapshot.venue.map((String string) {
                              
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string), 
                              );
                            }).toList():null,
                            
                            
                            onChanged: (val) {
                              print(val);
                              snapshot.updateVenue(val);
                              snapshot.getInchargeApprover(val);
                             
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 55,
                        width: 340,
                        child: Card(
                          elevation: 10,
                            child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                    "In Charge: ${snapshot.incharge.value}"))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 55,
                        width: 340,
                        child: Card(
                          elevation: 10,
                            child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                    "Approver: ${snapshot.approver.value}"))),
                      ),
                      TextFields(
                        maxlines: 2,
                        icons: Icons.school,
                        text: "Name Of Project",
                        textfield: nameofTheProject,
                      ),
                      TextFields(
                        maxlines: 2,
                        icons: Icons.nature,
                        text: "Nature Of Project",
                        textfield: natureofTheProject,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "General Objectives",
                        textfield: generaldescription,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "Specific Objectives",
                        textfield: specificdescription,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "Planning Stage",
                        textfield: planningstage,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "Implementation",
                        textfield: implementation,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "Resource Requirement",
                        textfield: resourcerequirement,
                      ),
                      TextFields(
                        maxlines: 10,
                        text: "Evaluation",
                        textfield: evaluation,
                      ),
                     Container(
                       margin: EdgeInsets.all(20),
                       child: DateTimeFormField(
                        
                        decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Time From',
                    ),
                    mode: DateTimeFieldPickerMode.time,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      String timeFrom = DateFormat('h:mma').format(value);
                      snapshot.getTimeFrom(timeFrom);
                      print(snapshot.timeFrom.value);
                    },
                  ),
                     ),
                     Container(
                       margin: EdgeInsets.all(20),
                       child: DateTimeFormField(
                        
                        decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Time Until',
                    ),
                    mode: DateTimeFieldPickerMode.time,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      String timeuntil = DateFormat('h:mma').format(value);
                      snapshot.getTimeUntil(timeuntil);
                      print(snapshot.timeUntil.value);
                    },
                  ),
                     ),
                     Container(
                       margin: EdgeInsets.all(20),
                       child: DateTimeFormField(
                        
                        decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Date of Event',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      String date = DateFormat('yyyy-MM-dd').format(value);
                      snapshot.getDate(date);
                      print(snapshot.date.value);
                    },
                  ),
                     ),
                     TextFields(
                        maxlines: 2,
                        text: "Description",
                        textfield: description,
                        icons: Icons.description,
                      ),
                      TextFields(
                        maxlines: 2,
                        text: "Beneficiaries",
                        textfield:beneficiaries,
                      ),

                      Container(
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.all(20),
                        child: Card(elevation: 10,
                        child: RaisedButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Create Event", softWrap: true, style: TextStyle(color: Colors.white, fontFamily: 'Mops', fontSize: 20), 
                          ),
                          onPressed: (){
                            final form =nokey.currentState;
                            if(form.validate()){
                              snapshot.createEvent(
                                this.id.toString(), 
                                this.orgname.toString(), 
                                this.orgtype.toString(), 
                                snapshot.date ,
                                nameofTheProject, 
                                natureofTheProject,
                                snapshot.venueString,
                                snapshot.timeFrom,
                                snapshot.timeUntil,
                                snapshot.incharge,
                                snapshot.approver,
                                beneficiaries,
                                description,
                                generaldescription,
                                specificdescription,
                                planningstage,
                                implementation,
                                resourcerequirement,
                                evaluation,
                                );
                              form.save();

                            }
                          },
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
