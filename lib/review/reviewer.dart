import 'package:e_shopp/exceptions/exceptions.dart';
class Reviewer{
  String  first_name,last_name,email,formatted_name;

  Reviewer(this.first_name, this.last_name, this.email, this.formatted_name);
  Reviewer.fromJson(Map<String,dynamic> jsonObject){

    if(jsonObject['first_name'] == null){
      throw PropertyIsRequired('First Name');
    }
    if(jsonObject['email'] == null){
      throw PropertyIsRequired('Email');
    }
    if(jsonObject['last_name'] == null){
      throw PropertyIsRequired('Last Name');
    }
    if(jsonObject['formatted_name'] == null){
      throw PropertyIsRequired('Formatted Name');
    }
    this.first_name = jsonObject['first_name'];
    this.last_name =jsonObject['last_name'];
    this.email= jsonObject['email'];
    this.formatted_name = jsonObject['formatted_name'];

  }


}