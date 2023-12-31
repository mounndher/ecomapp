import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mch/core/constant/routes.dart';

import '../services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  Myservices myservices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myservices.sharedPreferences.getString("onboarding") == "1") {
      return const RouteSettings(name: Approutes.login);
    }
  }
}
