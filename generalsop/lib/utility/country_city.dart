import 'package:generalsop/exceptions/exception.dart';

class CountryCity{
  int city_id;
  String city_name;

  CountryCity(this.city_id, this.city_name);

  CountryCity.fromJson(Map<String,dynamic>jsonObject){
    assert (jsonObject['city_id']!=null,'City ID is null');
    assert (jsonObject['city_name']!=null,'City Name is null');

    if(jsonObject['city_id']==null){
      throw PropertyRequired('City Id');
    }
    if(jsonObject['city_name']==null){
      throw PropertyRequired('City name');
    }
    this.city_id=jsonObject['city_id'];
    this.city_name=jsonObject['city_name'];
  }


}