import 'package:generalsop/api/api_util.dart';
import 'package:generalsop/exceptions/exception.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/product/product_tag.dart';
import 'package:generalsop/utility/country.dart';
import 'package:generalsop/utility/country_city.dart';
import 'package:generalsop/utility/country_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelpersApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<ProductCategory>> fetchCategories() async {
    List<ProductCategory> categories = [] ;
    String url = ApiUtl.CATEGORIES ;
    http.Response response = await http.get(url, headers: headers);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          categories.add(ProductCategory.fromJson(item));
        }
        return categories;
        break;
      case 404:
        throw ResourceNotFound('Categories');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
    }
  }

  Future<List<ProductTag>> fetchTags(int page) async {
    String url = ApiUtl.TAGS + '?page' + page.toString();
    http.Response response = await http.get(url, headers: headers);
    switch (response.statusCode) {
      case 200:
        List<ProductTag> tags = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          tags.add(ProductTag.fronJson(item));
        }
        return tags;
        break;
      case 404:
        throw ResourceNotFound('Tags');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<Country>> fetchCountries(int page) async {
    await checkInternet();
    String url = ApiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<Country> countries = [];

        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          countries.add(Country.fromJson(item));
        }
        return countries;
        break;
      case 404:
        throw ResourceNotFound('Contries');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<CountryState>> fetchStates(int country, int page) async {
    await  checkInternet();
    String url = ApiUtl.STATES(country) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<CountryState> states = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          states.add(CountryState.fromJson(item));
        }
        return states;
        break;
      case 404:
        throw ResourceNotFound('States');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<CountryCity>> fetchCities(int country, int page) async {
    await checkInternet();
    String url = ApiUtl.CITIES(country) + '?page=' + page.toString();
    http.Response response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List<CountryCity> cities = [];
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          cities.add(CountryCity.fromJson(item));
        }
        return cities;
        break;
      case 404:
        throw ResourceNotFound('Cities');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }
  }
}
