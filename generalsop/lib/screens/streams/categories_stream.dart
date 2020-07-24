import 'dart:async';

import 'package:generalsop/api/helpers_api.dart';
import 'package:generalsop/contracts/contracts.dart';
import 'package:generalsop/product/product_category.dart';

class CategoriesStream implements Disposable{
  List<ProductCategory> categories;


  StreamController<List<ProductCategory>> _caegoriesStream = StreamController<List<ProductCategory>>.broadcast(  );
  Stream<List<ProductCategory>> get categoriesStream  => _caegoriesStream.stream;
  StreamSink<List<ProductCategory>> get categoriesSink => _caegoriesStream.sink;

  HelpersApi helpersApi = HelpersApi();
  CategoriesStream(){
    categories = [];
    _caegoriesStream.add(categories);
    _caegoriesStream.stream.listen( _fetchCategories );
  }
  Future<void> _fetchFirstTime() async{
    categories = await helpersApi.fetchCategories();
  }
  Future<void> _fetchCategories ( List<ProductCategory> categories)async{
    print("before api call");
    this.categories = await helpersApi.fetchCategories();
    print("after api call");
    _caegoriesStream.add(this.categories);
    print(categories.length);
  }

  @override
  void dispose() {
    _caegoriesStream.close();
  }
}