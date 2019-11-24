import 'package:e_shopp/exceptions/exceptions.dart';
class CountryCity{
  int city_id ;
  String city_name ;

  CountryCity(this.city_id, this.city_name);
  CountryCity.fromJson(Map<String,dynamic> object){
    if(object['city_id'] == null){
      throw PropertyIsRequired('City ID');
    }
    if(object['city_name'] == null){
      throw PropertyIsRequired('City Name');
    }
    this.city_id=object['city_id'];
    this.city_name=object['city_name'];
  }

}