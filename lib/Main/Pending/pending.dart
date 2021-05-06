
import 'package:eventproposal/Main/Pending/others.dart';
import 'package:eventproposal/Main/Pending/proposal.dart';
import 'package:flutter/material.dart';

class OrganizationPending extends StatelessWidget {
  final String id;
  final String dropdownvalue;
  const OrganizationPending({Key key, this.id, this.dropdownvalue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(this.id);
    return DefaultTabController(
      length: 2,
    
      child: Scaffold(
        
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0.0,
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          bottom:TabBar(
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
            tabs: [
            Tab(
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.redAccent, width: 1),
                ),
                child: Align(alignment: Alignment.center, child: Text('Others'),),
            ),),
            Tab(
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.redAccent, width: 1),
                ),
                child: Align(alignment: Alignment.center, child: Text('SAO Proposal'),),
            ),),
            
          ],) ,),
        body: TabBarView(children: [
          Others(id: this.id, dropdownvalue: this.dropdownvalue,),
          Proposal(id: this.id, dropdownvalue: this.dropdownvalue,)
        ],),
      ),
    );
  }
}

            