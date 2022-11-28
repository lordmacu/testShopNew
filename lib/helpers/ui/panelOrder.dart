import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoptest/modules/orders/model/Order.dart';
import 'package:shoptest/modules/orders/model/Product.dart';

class PanelOrder extends StatelessWidget {
  PanelOrder({Key key, this.order});

  final Order order;
  var oCcy = new NumberFormat("#,##0.00", "en_US");

  Widget getProducts() {
    var productsGroup = groupBy(order.products, (Product obj) => obj.sku);

    List<Map<String, String>> productsList = [];

    productsGroup.forEach((key, List<Product> products) {
      String productName = products[0].title;
      int price = 0;
      products.forEach((element) {
        price += element.price;
      });

      productsList.add({"name": productName, "price": "${price}"});
    });

    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (BuildContext context, int index) {

          return Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productsList[index]['name']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "\$${oCcy.format(int.parse(productsList[index]['price']))}")
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Orden: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${order.orderNumber} ",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Cliente: ${order.client} "),
                Text("Orden: ${order.dateOrder} ")
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Text(
              "Ordenes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 200,
            child: getProducts(),
          )
        ],
      ),
    );
  }
}
