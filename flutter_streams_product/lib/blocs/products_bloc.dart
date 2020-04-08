import 'dart:async';

import 'package:flutterstreamsproduct/contracts/disposable.dart';
import 'package:flutterstreamsproduct/models/product.dart';

class ProductBloc implements Disposable{
  List<Product> products;
  final  StreamController<List<Product>> _productListStreamController= StreamController<List<Product>>();
  Stream <List<Product>> get productsStream => _productListStreamController.stream;
  StreamSink <List<Product>> get productStreamSink => _productListStreamController.sink;

  final StreamController<Product> _addProductStreamController=StreamController<Product>();
  StreamSink<Product> get addProduct=>_addProductStreamController.sink ;

  final StreamController<Product>_removeProductStreamController =StreamController<Product>();
  StreamSink<Product> get removeProduct =>_removeProductStreamController.sink;

  ProductBloc(){
    products=[
      Product("ABC", "New Product 1",3),
    Product("ABD", "New Product 2",4),
    Product("ABF", "New Product 3",5),
    Product("ABG", "New Product 4",6)

    ];
    _productListStreamController.add(products);
    _addProductStreamController.stream.listen(_addProduct);
    _removeProductStreamController.stream.listen(_removeProduct);
  }

  void _addProduct(Product product){
    products.add(product);
    productStreamSink.add(products);
  }

  void _removeProduct(Product product){
    products.remove(product);
    productStreamSink.add(products);
  }

  @override
  void dispose() {
  _productListStreamController.close();
  _addProductStreamController.close();
  _removeProductStreamController.close();
  }

}