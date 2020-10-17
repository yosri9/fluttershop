import 'package:flutterui/profiles/profiles_1/user.dart';

class ProfileProvider{

  static Profile getProfile(){

    return Profile(
      user: User(
        name: 'Erik Walters',
        address: '677 adams Bypass',
        about: "Manoeuvering small talk situations is an important skill — especially in the business context. To help you improve it, we have put together some examples of"
      ),
      followers: 2318,
      following: 364,
      friends: 175
    );

  }
}