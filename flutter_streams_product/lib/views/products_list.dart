import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstreamsproduct/blocs/products_bloc.dart';
import 'package:flutterstreamsproduct/models/product.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductBloc productBloc=ProductBloc();

  @override
  void dispose() {
   productBloc.dispose();
    super.dispose();
  }

  TextStyle _mstyle=TextStyle(
    fontSize: 18
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: productBloc.productsStream,
        // ignore: missing_return
        builder: (BuildContext context ,AsyncSnapshot<List<Product>> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.none:
              case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              // ignore: missing_return
              );
              break;
            case ConnectionState.active:
              case ConnectionState.done:
              if(snapshot.hasError){
                return Text('Error!');
              }else{
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                            itemBuilder: (context,position){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(snapshot.data[position].title ,style: _mstyle,),
                                Text(snapshot.data[position].qty.toString(), style: _mstyle),
                                RaisedButton(
                                    child: Text('REMOVE'),
                                    onPressed: (){
                                      productBloc.removeProduct.add(snapshot.data[position]);
                                    }
                                    ),

                              ],
                            ),
                          );
                        }),
                      ),
                      RaisedButton(
                          child: Text('ADD NEW'),
                          onPressed: (){
                            Product product =Product("azeaze", "zeaze", 45);
                            productBloc.addProduct.add(product);
                          }
                      )
                    ],
                  ),
                );
              }
              break;
          }
        },
    );
  }
}
