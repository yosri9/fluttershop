import 'package:flutter/material.dart';
import 'package:generalsop/api/helpers_api.dart';
import 'package:generalsop/api/product_api.dart';
import 'package:generalsop/product/product.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/screens/home_page.dart';
import 'package:generalsop/screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/authentication.dart';
import 'exceptions/exception.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if ( isSeen == null || !isSeen ){
    homePage = OnBoarding();
  }
  runApp(GeneralShop(homePage));
}

class GeneralShop extends StatelessWidget {
  final Widget homePage ;

  GeneralShop(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
    );
  }
}


