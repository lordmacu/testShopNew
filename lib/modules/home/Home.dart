import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoptest/helpers/ColorsTheme.dart';
import 'package:shoptest/helpers/ui/buttonWidget.dart';
import 'package:shoptest/modules/login/Login.dart';
import 'package:shoptest/modules/login/LoginController.dart';
import 'package:shoptest/modules/orders/OrderController.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final OrderController _cartController = Get.put(OrderController());
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: ColorsTheme.backGrondGradient,
          child: Center(
              child: ButtonW(
            onTab: () {
              Get.to(Login());
            },
            label: "Ingresar",
            colorText: ColorsTheme.textColor,
            colorBackground: Colors.white,
          )),
        ),
      ),
    );
  }
}
