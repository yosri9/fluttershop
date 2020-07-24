import 'package:flutter/material.dart';
import 'package:generalsop/api/helpers_api.dart';
import 'package:generalsop/api/product_api.dart';
import 'package:generalsop/product/product.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/screens/home_page.dart';
import 'package:generalsop/screens/onboarding/onboarding.dart';
import 'package:generalsop/screens/utilities/screen_utilities.dart';
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
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline: TextStyle(
            fontFamily: "Quicksnad",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: ScreenUtilities.textColor
          ),
          subhead: TextStyle(
            fontFamily: "Quicksnad",
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: ScreenUtilities.textColor
          ),
        ),
        appBarTheme: AppBarTheme(
          actionsIconTheme:IconThemeData(
              color: ScreenUtilities.textColor
          ) ,
          elevation: 0,
          textTheme: TextTheme(
              title: TextStyle(
                  color: ScreenUtilities.textColor,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.w700,
                  fontSize: 22
              )
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: ScreenUtilities.textColor,
          labelStyle: TextStyle(
            fontFamily: "Quicksnad",
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          labelPadding: EdgeInsets.only( left: 16 , right: 16 , bottom: 12 , top: 16 ),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ScreenUtilities.unselected,
          unselectedLabelStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: "Quicksand"
          ),

        )

      ),
    );
  }
}


