import 'package:generalsop/exceptions/exception.dart';

class Reviewer {
  String first_name,last_name,email,formatted_name;

  Reviewer(this.first_name, this.last_name, this.email, this.formatted_name);

  Reviewer.fromJson(Map <String,dynamic> jsonObject){

    assert(jsonObject['first_name'] !=null , 'First Name is Null');
    assert(jsonObject['last_name'] !=null , 'Last Name is Null');
    assert(jsonObject['email'] !=null , 'Email is Null');
    assert(jsonObject['formatted_ame'] !=null , 'Formatted Name is Null');

    if(jsonObject['first_name']==null){
      throw PropertyRequired('First Name');
    }
    if(jsonObject['last_name']==null){
      throw PropertyRequired('Last Name');
    }
    if(jsonObject['email']==null){
      throw PropertyRequired('Email');
    }
    if( jsonObject['formated_name'] == null ){
      throw PropertyRequired('First Name');
    }

    this.first_name=jsonObject['first_name'];
    this.last_name=jsonObject['last_name'];
    this.email=jsonObject['email'];
    this.formatted_name=jsonObject['formatted_name'];

  }


}