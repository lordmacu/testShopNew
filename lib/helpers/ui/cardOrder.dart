import 'package:flutter/material.dart';
import 'package:shoptest/modules/orders/model/Order.dart';

class CardOrderW extends StatelessWidget {
  const CardOrderW({Key key, this.onTab, this.order});

  final Function onTab;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.only(bottom: 20,left: 10,right: 10,top: 10),
        padding: EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Pedido"), Text("${order.orderNumber}")],
              ),
            ),
            Container(child: Text("${order.client}")),
            Container(child: Text("${order.dateOrder}"))
          ],
        ),
      ),
    );
  }
}
