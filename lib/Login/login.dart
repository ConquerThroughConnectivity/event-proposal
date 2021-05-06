import 'package:eventproposal/Controllers/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
class Login extends StatelessWidget {
  @override
final TextEditingController schoolID = new TextEditingController();
final TextEditingController password = new TextEditingController();
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      body: DirectSelectContainer(
        child: GetBuilder<LoginContrller>(
          init: LoginContrller(),
          builder: (snapshot){
          return ModalProgressHUD(
            color: Colors.redAccent,
            inAsyncCall: snapshot.islogin.value,
            child: Stack(
            children: [
               PlayAnimation(
                 duration: Duration(seconds: 2),
                 tween: Colors.redAccent.tweenTo(Colors.white),
                 builder: (context, child, value){
                   return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: ExactAssetImage('lib/assets/background.jpg'), fit: BoxFit.cover)),
                    child: Stack(
                     children: [
                    // CircularParticle(
                    // key: UniqueKey(),
                    // awayRadius: 200, 
                    // numberOfParticles: 200,
                    // speedOfParticles: 2,
                    // height: 1000,
                    // width: 500,
                    // onTapAnimation: true,
                    // particleColor: Colors.white.withAlpha(150),
                    // awayAnimationDuration: Duration(milliseconds: 600),
                    // maxParticleSize: 5,
                    // isRandSize: true,
                    // isRandomColor: false,
                    // randColorList: [
                    //   Colors.red.withAlpha(210),
                    //   Colors.white.withAlpha(210),
                    //   Colors.yellow.withAlpha(210),
                    //   Colors.green.withAlpha(210)
                    // ],
                    // awayAnimationCurve: Curves.easeInOutBack,
                    // enableHover: true,
                    // hoverColor: Colors.white,
                    // hoverRadius: 90,
                    // connectDots: false //not recommended 
                    // ),
                    Form(
                    key: key,
                    child: Card(
                      
                      borderOnForeground: true,
                      color:value.withOpacity(0.8),
                      elevation: 10,
                      margin: EdgeInsets.only(top: 140,left: 20, right: 20, bottom: 160),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40,left: 40, right: 40, bottom: 50),
                        child: Column(children: [
                             Card(
                               elevation: 15,
                               child: DirectSelectList(
                                  focusedItemDecoration: BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(width: 1, color: Colors.black12),
                                    top: BorderSide(width: 1, color: Colors.black12),
                                  ),
                              ),
                                  itemBuilder: (value) => DirectSelectItem<String>(
                                  value: value,
                                  itemBuilder: (context, value)=> Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Text(value))),
                                  values: snapshot.dropdown,
                                  onItemSelectedListener:(item, index, context){
                                    snapshot.getData(item);
                                    print(snapshot.getData(item));
                                  } ,
                              ),
                               ),
                           
                          
                          SizedBox(height: 30,),
                          TextFormField(
                            controller: schoolID,
                            autocorrect: true,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[1234567890]")), LengthLimitingTextInputFormatter(10),],
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onChanged: (val){
                              
                            },
                            validator: (val){
                              if(val.isEmpty){
                                return 'Cannot Be Empty';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'School ID',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              fillColor: Colors.red,
                              filled: true,
                              prefixIcon: Icon(Icons.school, color: Colors.white,),
                            ),
                            ),
                          SizedBox(height: 30,),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            autocorrect: true,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-1234567890]")), LengthLimitingTextInputFormatter(10) ],
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onChanged: (val){
                              
                            },
                            validator: (val){
                              if(val.isEmpty){
                                return 'Cannot Be Empty';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                
                              ),
                              fillColor: Colors.red,
                              filled: true,
                              prefixIcon: Icon(Icons.school, color: Colors.white,),
                            ),
                            ),
                            SizedBox(height: 50,),
                            RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.5)),
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                child: Center(child: Text('Login',style: TextStyle(color: Colors.white, fontSize: 17),)),),
                              onPressed: (){
                                final form =key.currentState;
                                if(form.validate()){
                                  if(snapshot.val.value ==""){
                                    print("Select Login Type");
                                  }else{
                                    snapshot.login(snapshot.val.value,schoolID.text, password.text);
                                    form.save();
                                  }
                                  
                                }
                              },),
                            
                            
                        ],),
                      ),
                    ),
                    ),
                   ],)
                 );
                 },
               ),
            
        ],),
          );
          },

        ),
      ));
  }
}