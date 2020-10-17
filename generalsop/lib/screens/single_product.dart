import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalsop/api/cart_api.dart';
import 'package:generalsop/product/product.dart';
import 'package:generalsop/screens/login.dart';
import 'package:generalsop/screens/utilities/helpers_widgets.dart';
import 'package:generalsop/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  CartApi cartApi = CartApi();
  bool _addingToCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child:( _addingToCart ) ? CircularProgressIndicator() : Icon(Icons.add_shopping_cart),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          int userID = pref.getInt('user_id');
          if (userID == null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else {
            setState(() {
              _addingToCart = true;
            });
            await CartApi.addProductToCart(widget.product.product_id);
            setState(() {
              _addingToCart = false;
            });
          }
        },
      ),
    );
  }

  Widget _drawScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: _drawImageGallery(context),
              ),
              _drawTitle(context),
              _drawDetails(context),
            ],
          ),
        ),
        _drawLine(),
      ],
    );
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
        itemCount: widget.product.images.length,
        itemBuilder: (context, int position) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(widget.product.images[position]),
            ),
          );
        });
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.product.productCategory.category_name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '\$ ${widget.product.product_price.toString()}',
                  style: Theme.of(context).textTheme.headline,
                ),
                (widget.product.product_discount > 0)
                    ? Text(
                        _calculateDiscount(),
                        style: Theme.of(context).textTheme.subhead,
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.product.product_description,
        style: Theme.of(context).textTheme.display2,
      ),
    );
  }

  String _calculateDiscount() {
    double discount = widget.product.product_discount;
    double price = widget.product.product_price;
    return (price * discount).toString();
  }

  Widget _drawLine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -45),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 16),
          padding: EdgeInsets.only(left: 20),
          height: 1,
          color: ScreenUtilities.lightGrey,
        ),
      ),
    );
  }
}
