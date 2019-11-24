import 'package:e_shopp/exceptions/exceptions.dart';

class CountryState{
  int state_id ;
  String state_name ;

  CountryState(this.state_id, this.state_name);

  CountryState.fromJson(Map<String,dynamic> object){
    if(object['state_id'] == null){
      throw PropertyIsRequired('State ID');
    }
    if(object['state_name'] == null){
      throw PropertyIsRequired('State Name');
    }
    this.state_id=object['state_id'];
    this.state_name=object['state_name'];

  }

}