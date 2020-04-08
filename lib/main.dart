import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/admin/add_category.dart';
import 'package:flutterapp/admin/add_product.dart';
import 'package:flutterapp/admin/categories.dart';
import 'package:flutterapp/admin/products.dart';


void main (){
  runApp(FlutterShop());
}

class FlutterShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthTest(),
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      routes: {

        '/add_category':(context)=>AddCategoryScreen(),
        '/categories': (context)=>AllCategories(),
        '/add_product':(context)=>AddProduct(),
        '/products':(context)=>AllProducts(),
      },
    );
  }
}

class AuthTest  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AuthTest> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Shop'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           ListTile(
                title: Text('All Products'),
                onTap:() {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/products');
                }
            ),
            ListTile(
                title: Text('Add Products'),
                onTap:() {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/add_products');
                }
            ),ListTile(
                title: Text('All Categories'),
                onTap:() {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/categories');
                }
            ),
            ListTile(
                title: Text('Add Category'),
                onTap:() {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/add_category');
                }
            ),
          ],
        ),
      ),
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Auth Test'),
//      ),
//      body: Container(
//        padding: EdgeInsets.only(left: 24,right: 24),
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text('Register'),
//              SizedBox(height: 16,),
//
//              TextFormField(
//                  controller: _emailController,
//                  keyboardType:TextInputType.emailAddress ,
//                  decoration: InputDecoration(
//                    hintText: 'Email'
//                  ),
//              ),
//              SizedBox(height: 16,),
//
//              TextFormField(
//                controller: _passwordController,
//                obscureText: true,
//                decoration: InputDecoration(
//                  hintText: 'Password'
//                ),
//
//              ),
//              SizedBox(height: 16,),
//              RaisedButton(
//                  child: Text('Register'),
//                  onPressed: ()async{
//                  String email=_emailController.text;
//                  String password= _passwordController.text;
//
//                  var user= await firebaseAuthentication.register(email, password);
//                  }
//                  ),
//              SizedBox(height: 16,),
//              RaisedButton(
//                  child: Text('SignOut'),
//                  onPressed: ()async{
//                    firebaseAuthentication.signOut();
//
//                  }
//              )
//            ],
//          ),
//        ),
//      ),
//
//    );
//  }
}

