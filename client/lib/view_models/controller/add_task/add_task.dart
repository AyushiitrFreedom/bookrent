import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:getx_mvvm/repository/addtask/addtask.dart';

import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/utils/utils.dart';

import '../home/home_view_models.dart';
 
class AddTaskController extends GetxController {
  final _api = AddTaskRepository();
   final homeController = Get.put(HomeController());
  final titleController = TextEditingController().obs;
  final key = ''.obs;
  final priceController = TextEditingController().obs;

  final titleFocusNode = FocusNode().obs;
  final priceFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void addtaskApi() {
    loading.value = true;
    Map<dynamic, dynamic> data = {
      'key' : key,
      'price' : int.parse(priceController.value.text),

    };

    _api.addTask(jsonEncode(data)).then((value) {
      loading.value = false;
     
        Get.delete<AddTaskController>();
   
        Get.toNamed(RouteName.completedanimation);
      }
    ).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('Error', error.toString());
    });
  }
}
