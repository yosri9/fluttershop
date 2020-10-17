import 'dart:convert';

import 'package:generalsop/cart/cart.dart';
import 'package:generalsop/exceptions/exception.dart';
import 'package:http/http.dart' as http ;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';
class CartApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  static Future<Cart> fetchCart() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer' + apiToken

    };
    await checkInternet();
    String cartApi = ApiUtl.CART;
    http.Response response = await http.get(cartApi , headers: authHeaders );
    switch( response.statusCode ){
      case 200:
        var body = jsonDecode(response.body);
        return Cart.fromJson(body);
        break;
      default:
        throw ResourceNotFound('Cart');
    }
  }
  static Future <void> addProductToCart ( int productID) async{
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String cartApi = ApiUtl.CART;
    Map<String,dynamic> body = {
      'product_id' : productID.toString(),
      'qty' : 1.toString()
    };
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer' + apiToken

    };
    http.Response response = await http.post( cartApi , headers: authHeaders , body: body );
    switch( response.statusCode){
      case 200:
      case 201:
        return true;
        break;
      default:
      throw ResourceNotFound('Cart');
      break;
    }
  }
}