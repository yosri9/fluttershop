import 'package:flutter/material.dart';
import 'package:generalsop/api/product_api.dart';
import 'package:generalsop/product/product.dart';
import 'api/authentication.dart';

void main(){
  runApp(GeneralShop());
}
class GeneralShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductApi productApi=ProductApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Shop'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future:    productApi.fetchproduct(75),
            builder: (BuildContext context,AsyncSnapshot <Product> snapShot){
              print("");

              switch(snapShot.connectionState){
                case ConnectionState.none:

                  _error('nothing happened !!!');
                  break;
                case ConnectionState.waiting:

                  return _loading();
                  break;
                case ConnectionState.active:

                  _loading();
                  break;
                case ConnectionState.done:
                  if(snapShot.hasError){
                    return _error(snapShot.error.toString());
                  }else{
                    if(! snapShot.hasData){

                      return _error('no data');
                    }else{

                         return _drawProduct(snapShot.data)   ;



                    }
                  }
                  break;
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
  _drawProduct(Product product){
    return Card(
      child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(product.product_title),
              (product.images.length>0) ?
              Image(
                  image: NetworkImage(product.images[0])
              ): Container()
            ],
          )
      ),
    );
  }
  _error(String error){
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }
  _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
