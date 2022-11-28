import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoptest/helpers/ColorsTheme.dart';
import 'package:shoptest/helpers/ui/buttonWidget.dart';
import 'package:shoptest/modules/login/LoginController.dart';
import 'package:shoptest/modules/orders/OrderController.dart';
import 'package:shoptest/modules/orders/orders.dart';

class Login extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(ColorsTheme.generalPadding),
          decoration: ColorsTheme.backGrondGradient,
          child: Center(
              child: Form(
            key: _loginController.formKeyLogin.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    children: [
                      Text(
                        'Ingresar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return ' Ingresa el correo electrónico';
                        }
                        return null;
                      },
                      onChanged: (text) {},
                      obscureText: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin:
                        EdgeInsets.only(bottom: ColorsTheme.inputMarginButton),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ' Ingresa la contraseña';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        _loginController.password.value = text;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                  child: ButtonW(
                    onTab: () async {
                      final isValid = _loginController
                          .formKeyLogin.value.currentState
                          .validate();

                      if (isValid) {
                        await _orderController.loadOrders();
                        Get.to(Orders());
                      } else {
                        Get.snackbar('Datos Incorrectos', 'Verifica tus datos');
                      }
                    },
                    label: "Iniciar Sesion",
                    colorText: ColorsTheme.textColor,
                    colorBackground: Colors.white,
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
