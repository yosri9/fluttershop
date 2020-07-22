
  import 'dart:async';

import 'package:generalsop/api/product_api.dart';
import 'package:generalsop/contracts/contracts.dart';
import 'package:generalsop/product/product.dart';

class HomeProductBloc implements Disposable {
  List<Product> products;
  ProductApi productApi ;

  final StreamController <List<Product>> _productsController = StreamController<List<Product>>.broadcast();
  final StreamController<int> _categoryController = StreamController<int>.broadcast();

  Stream<List<Product>> get productsStream => _productsController.stream;

  StreamSink <int> get fetchProduct => _categoryController.sink;
  Stream<int> get category => _categoryController.stream;

  int categoryID;


  HomeProductBloc(){
   products = [];
   productApi = ProductApi();
   _productsController.add(this.products);
   _categoryController.add(this.categoryID);
   _categoryController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi( int category ) async{
    this.products = await productApi.fetchProductsByCategory(category, 1);
    _productsController.add(this.products);

  }

  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
  }


  }