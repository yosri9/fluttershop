import 'package:flutterapp/main.dart';
import 'package:flutterapp/order/order_controller.dart';
import 'package:flutterapp/product/product_controller.dart';
import 'package:flutterapp/user/address.dart';

import 'user.dart';
import 'package:flutterapp/product/base_product.dart';
import 'package:flutterapp/order/base_order.dart';

class Customer extends User {

  Address shippingAddress;
  Address billingAddress;
  List <BaseProduct> watchList;
  List <BaseOrder> orders;

  Customer(
      String id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String gender,
      Address shippingAddress ,
      Address billingAddress ,
      List<BaseProduct> watchList,
      List<BaseOrder> orders
      )
      : super(id, firstName, lastName, email, phone, gender){
    this.shippingAddress=shippingAddress;
    this.billingAddress=billingAddress;
    this.watchList=watchList;
    this.orders=orders;
  }

  Customer.fromJson(Map <String,dynamic>jsonObject)
      : super(
      jsonObject['id'],
      jsonObject['firstname'],
      jsonObject['lastname'],
      jsonObject['email'],
      jsonObject['phone'] ,
      jsonObject['gender'],
  ) {
   this.shippingAddress= Address.fromJson(jsonObject['shipping_address']);
   this.billingAddress= Address.fromJson(jsonObject['billing_address']);
   this.watchList= ProductController.toProducts(jsonObject['watch_list']);
   this.orders= OrderController.toOrders(jsonObject['orders']);
  }

}