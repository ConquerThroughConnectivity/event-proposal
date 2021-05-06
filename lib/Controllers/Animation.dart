





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class AnimationControllers extends GetxController{
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  RxInt ind =0.obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  RxInt getIndex(int index){
    ind =index.obs;
    return ind;
  }

}