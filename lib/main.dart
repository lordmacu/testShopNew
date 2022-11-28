import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoptest/database/DatabaseHelper.dart';
import 'package:shoptest/helpers/routes.dart';
import 'package:shoptest/modules/home/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Shop(title: 'Shop app'),
    );
  }
}

class Shop extends StatefulWidget {
  Shop({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopApp createState() => _ShopApp();
}

class _ShopApp extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
      getPages: appRoutes(),
    );
  }
}
