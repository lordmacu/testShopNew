import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKeyLogin = GlobalKey<FormState>().obs;

  var email = ''.obs;
  var password = ''.obs;
}
