import 'package:flutterapp/user/customer.dart';
import 'package:flutterapp/order/base_order.dart';
import 'package:flutterapp/product/base_product.dart';


class CustomerController{

  Customer customer ;


 CustomerController(this.customer);

  void addToOrders(BaseOrder order){
    this.customer.orders.add(order);
  }

  void addToWatchList(BaseProduct product){
    this.customer.watchList.add(product) ;
  }
  bool orderInOrders(BaseOrder order){
    return this.customer.orders.contains(order);
  }

  bool productInWatchList(BaseProduct product){
    return this.customer.watchList.contains(product);
  }

  bool removeProductFromWatchList(BaseProduct product){
    return this.customer.watchList.remove(product);
  }
}