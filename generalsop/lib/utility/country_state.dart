import 'package:generalsop/exceptions/exception.dart';

class CountryState{
  int state_id;
  String state_name;

  CountryState(this.state_id, this.state_name);
  CountryState.fromJson(Map<String,dynamic>jsonObject){
    assert(jsonObject['state_id']!=null,'Stae ID is null');
    assert(jsonObject['state_name']!=null,'Stae Name is null');

    if(jsonObject['state_id']==null){
      throw PropertyRequired('State ID');
    }
    if(jsonObject['state_name']==null){
      throw PropertyRequired('State Name');
    }
    this.state_id=jsonObject['state_id'];
    this.state_name=jsonObject['json_name'];
  }

}