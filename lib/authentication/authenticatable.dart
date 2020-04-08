import 'package:flutterapp/user/user.dart';

class Authenticatable{
  Future<User> register(String email, String password){}
  Future<bool> login(String userName ,String password){}
  Future<bool> resetPassword(String email){}
  Future<User> updateProfile(User user){}

}