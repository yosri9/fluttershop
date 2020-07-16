import 'package:generalsop/exceptions/exception.dart';

class Country{
int country_id;
String country_name,capital,currency;

Country(this.country_id, this.country_name, this.capital, this.currency);

Country.fromJson(Map<String,dynamic>jsonObject){
  assert(jsonObject['country_id']!=null,'Country ID is null');
  assert(jsonObject['country_name']!=null,'Country Name is null');
  assert(jsonObject['country_capital']!=null,'Country Capital is null');
  assert(jsonObject['country_currency']!=null,'Country Currency is null');

  if(jsonObject['country_id']==null){
    throw PropertyRequired('Country');
  }
  if(jsonObject['country_name']==null){
    throw PropertyRequired('Country Name');
  }
  if(jsonObject['country_currency']==null){
    throw PropertyRequired('Country currency');
  }
  if(jsonObject['country_capital']==null){
    throw PropertyRequired('Country capital');
  }

  this.country_id=jsonObject['country_id'];
  this.country_name=jsonObject['country_name'];
  this.currency=jsonObject['currency'];
  this.capital=jsonObject['capital'];
}

}