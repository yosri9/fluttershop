import 'dart:core';

import 'dart:core';

import 'package:connectivity/connectivity.dart';
import 'package:generalsop/exceptions/exception.dart';


class ApiUtl{


//  static const String MAIN_API_URL="http://127.0.0.1:8000/api/";
  static const String MAIN_API_URL="http://46.101.174.178/api/";

  static const String AUTH_REGISTER=MAIN_API_URL+'auth/register';
  static const String AUTH_LOGIN=MAIN_API_URL+'auth/login';
  static const String PRODUCTS  = MAIN_API_URL+'products';
  static const String PRODUCT  = MAIN_API_URL+'products/';
  static  String CATEGORY_PRODUCTS(int id , int page){
   return MAIN_API_URL+'categories/'+ id.toString()+'/products?page='+ page.toString();
  }


  static const String COUNTRIES=MAIN_API_URL+'contries';
  static  String CITIES(int id){
    return MAIN_API_URL+COUNTRIES+'/'+id.toString()+'/cities';
  }
  static const String CATEGORIES=MAIN_API_URL + 'categories';
  static const String TAGS=MAIN_API_URL + 'tags';

  static String STATES(int id){
   return MAIN_API_URL+'countries/'+id.toString()+'/states';
  }



  }
Future <void> checkInternet() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile && connectivityResult == ConnectivityResult.wifi) {
    throw NoInternetConnection();
  }


}