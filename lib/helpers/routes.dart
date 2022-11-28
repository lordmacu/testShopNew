import 'package:get/get.dart';
import 'package:shoptest/modules/home/Home.dart';
import 'package:shoptest/modules/login/Login.dart';
import 'package:shoptest/modules/orders/AddOrder.dart';

appRoutes() => [
      GetPage(name: 'home', page: () => Home()),
      GetPage(name: 'addProduct', page: () => AddOrder()),
      GetPage(name: 'login', page: () => Login())
    ];
