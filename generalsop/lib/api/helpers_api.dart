import 'package:generalsop/api/api_util.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/product/product_tag.dart';
import 'package:generalsop/utility/country.dart';
import 'package:generalsop/utility/country_city.dart';
import 'package:generalsop/utility/country_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HelpersApi{
  Map<String,String>headers={
    'Accept' : 'application/json'
  };

  Future<List<ProductCategory>> fetchCategories(int page)async{
    String url=ApiUtl.CATEGORIES+'?page='+page.toString();
    http.Response response=await http.get(url,headers: headers);
    List<ProductCategory> categories=[];
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for (var item in body['data']){
        categories.add(
          ProductCategory.fromJson(item)
        );
      }
    }else{

    }
    return categories;
  }

  Future <List<ProductTag>>fetchTags(int page)async{
    String url=ApiUtl.TAGS +'?page'+page.toString();
    http.Response response=await http.get(url,headers: headers);
    List<ProductTag> tags=[];
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for(var item in body['data']){
      tags.add(ProductTag.fronJson(item));
    }

    }else{

    }
    return tags;


  }

  Future<List<Country>> fetchCountries(int page)async{
    String url=ApiUtl.COUNTRIES+'?page='+page.toString();
    http.Response response=await http.get(url,headers: headers);
    List<Country>countries=[];

    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for(var item in body['data']){
        countries.add(Country.fromJson(item));
      }
    }else{

    }
    return countries;

  }
  Future<List<CountryState>>fetchStates(int country,int page)async{
    String url=ApiUtl.STATES(country)+'?page='+page.toString();
    http.Response response=await http.get(url,headers: headers);
    List<CountryState>states=[];

    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for(var item in body['data']){
        states.add(CountryState.fromJson(item));
      }
    }else{

    }
    return states;

  }

 Future<List<CountryCity>> fetchCities(int country, int page)async{
    String url=ApiUtl.CITIES(country)+'?page='+page.toString();
    http.Response response=await http.get(url,headers: headers);
    List<CountryCity>cities=[];

    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for(var item in body['data']){
        cities.add(CountryCity.fromJson(item));
      }
      return cities;
    }else{

    }

  }


}