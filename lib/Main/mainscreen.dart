import 'package:eventproposal/Controllers/Animation.dart';
import 'package:eventproposal/Controllers/organization.dart';
import 'package:eventproposal/Login/login.dart';
import 'package:eventproposal/Main/Accepted/accepted.dart';
import 'package:eventproposal/Main/Pending/pending.dart';
import 'package:eventproposal/Main/Rejected/rejected.dart';
import 'package:eventproposal/Main/create.dart';
import 'package:eventproposal/utilities/calendar.dart';
import 'package:eventproposal/utilities/globalevents.dart';
import 'package:eventproposal/utilities/republicAct.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
class MainScreen extends StatefulWidget {
  final id;
  final dropdownvalue;
  const MainScreen({Key key, this.id, this.dropdownvalue}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var activeIndex =0;
  void _onTap(int index) {
    setState((){
      activeIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=>false,
      child: Scaffold(
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
          title: GetBuilder<Organization>(
            init: Organization(),
            builder: (snapshot){
            snapshot.getDetails(widget.id, widget.dropdownvalue);
            return Column(children: [
              Text(snapshot.fullname.value, style: TextStyle(fontSize: 12),),
              Text(snapshot.fullDepartment.value, style: TextStyle(fontSize: 12),),
            ],);
          },),
          ),
        floatingActionButton: GetBuilder<Organization>(
          init: Organization(),
          builder: (snapshot){
          return FloatingActionButton(
            elevation: 8,
            backgroundColor: Colors.red,
            child: Icon(
              Icons.add,
              color: Colors.white
            ),
            onPressed: () { 

              getDates(snapshot);
            
               
            },
        );
          },),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
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
          ],),
          body: activeIndex ==0 ?OrganizationPending(id: widget.id, dropdownvalue: widget.dropdownvalue,) :activeIndex ==1 ? OrganizationAccepted(id: widget.id, dropdownvalue: widget.dropdownvalue) : activeIndex ==2 ?OrganizationRejected(id: widget.id, dropdownvalue: widget.dropdownvalue) :TodayEvents(),
          
          ),
    ); 
  }

  void getDates(snapshot){
    final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MM');
  final DateFormat formatters = DateFormat('dd');
  final DateFormat formatterss = DateFormat('yyyy');
  final String formatted = formatter.format(now);
  final String formatteds = formatters.format(now);
  final String formattedss = formatterss.format(now);
  // print(formatted); 
  //  print(formatteds); 
  //   print(formattedss);
  // pri
String noew = formatteds+'/'+formatted+'/'+formattedss; 
print(noew);
    if(noew == "23/07/$formattedss" || 
    noew == "24/07/$formattedss" ||
    noew == "25/07/$formattedss" || 
    noew == "26/07/$formattedss" ){
      
      //first
      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );
      

    }else if(noew == "05/09/$formattedss" ||
    noew == "06/09/$formattedss" ||
    noew == "07/09/$formattedss" ||
    noew == "08/09/$formattedss" ||
    noew == "09/09/$formattedss" ||
    noew == "10/09/$formattedss" ){

      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );

    }else if(noew == "21/10/$formattedss" ||  
    noew == "22/10/$formattedss" ||
    noew == "23/10/$formattedss" ){

      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );


    }else if(noew == "16/12/$formattedss" ||
    noew == "17/12/$formattedss" ||
    noew == "18/12/$formattedss" ||
    noew == "19/12/$formattedss" ){


      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );

    }else if(noew == "10/02/$formattedss" ||
    noew == "11/02/$formattedss" ||
    noew == "12/02/$formattedss" || 
    noew == "13/02/$formattedss" ){


      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );

    }else if(noew == "26/02/$formattedss" ||
    noew == "27/02/$formattedss" ||
    noew == "28/02/$formattedss" ||
    noew == "29/02/$formattedss" ||
    noew == "30/02/$formattedss" ){

      Get.defaultDialog(
        title: "First Semester",
        middleText: "Banned Period.",
        backgroundColor: Colors.blue,
        barrierDismissible: true
        );

    }else{
       showDialog(
               context: context,
               barrierDismissible: true,
               builder: (context){
                  
 
                 return SingleChildScrollView(
                   child: Stack(children: [
                    Container(
                    child: Card(
                    child: Column(children: [
                      RepublicAct(),
                      CreateEvent(id: widget.id, orgname: snapshot.orgyName.value, orgtype: snapshot.orgyType,),
                    ],),
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.all(10),
                    color: Colors.white,),
                  )
                   ],),);
               }
             );
    }




  }

}