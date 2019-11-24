import 'package:e_shopp/exceptions/exceptions.dart';
class Country{
int country_id ;
String country_name , capital , currency ;

Country(this.country_id, this.country_name, this.capital, this.currency);

Country.fromJson(Map<String,dynamic> object){
  if(object['country_id'] == null){
    throw PropertyIsRequired('Country ID');
  }
  if(object['country_name'] == null){
    throw PropertyIsRequired('Country Name');
  }
  if(object['capital'] == null){
    throw PropertyIsRequired('Capital');
  }
  if(object['currency'] == null){
    throw PropertyIsRequired('Currency');
  }this.country_id = object['country_id'];
  this.country_name =object['country_name'];
  this.capital = object['capital'];
  this.currency= object['currency'];
}

}