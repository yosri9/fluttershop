import 'package:generalsop/customer/user.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'dart:convert';

class Authentication {
  Future<User> register(String first_name, String last_name, String email,
      String password) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password
    };

    http.Response response =
        await http.post(ApiUtl.AUTH_REGISTER, headers: headers, body: body);
    if (response.statusCode == 201) {
      var body = jsonDecode(response.body);
      var data = body['data'];
      return User.fromJson(data);
    }
    return null;
  }

  Future<User> login(String email, String password) async {
    Map<String, String> headers = {'Accept': 'application/json'};
    Map<String, String> body = {'email': email, 'password': password};

    http.Response response =
        await http.post(ApiUtl.AUTH_LOGIN, headers: headers, body: body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data=body['data'];
      print(data);
      return User.fromJson(data);
    }
  }
}
