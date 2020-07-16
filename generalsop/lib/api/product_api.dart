import 'package:generalsop/product/product.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'dart:convert';

class ProductApi {
  Map<String, String> headers = {'Accept': 'application/json'};
  Future<List<Product>> fetchProducts(int page) async {
    await checkInternet();
    String url = ApiUtl.PRODUCTS;

    http.Response response = await http.get(url, headers: headers);
    print(response.statusCode);

    List<Product> products = [];
    if (response.statusCode == 200) {

      var body = jsonDecode(response.body);

//      print(body['data']);
      for (var item in body['data']) {

        products.add(Product.fromJson(item));

      }

      return products;
    }
    return null;
  }
  Future<Product>fetchProduct(int product_id) async{
    await checkInternet();
    String url =ApiUtl.PRODUCT +product_id.toString();
    http.Response response=await http.get(url,headers: headers);
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      return Product.fromJson(body['data']);
    }
    return null;
  }
}
