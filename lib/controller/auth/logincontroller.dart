
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mch/core/constant/routes.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handlingdatacontroler.dart';
import '../../data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();
  goToSinUp();
  goToForgetPassword();
}

class LoginControllerimp extends LoginController {
  late TextEditingController email;
  late TextEditingController password;

  List data = [];
  StatusRequest? statusRequest=StatusRequest.none;
  LoginData loginData = LoginData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isshowpassword = true;
  showpassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async{
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text,password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(Approutes.home);
        } else {
          Get.defaultDialog(
              title: "ُWarning",
              middleText: "Password Or Email  Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
    
  }

  @override
  goToSinUp() {
    Get.offNamed(Approutes.signUp);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(Approutes.forgetPassword);
  }

  @override
  void onInit() {
    
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
