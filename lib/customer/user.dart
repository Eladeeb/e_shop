import 'package:e_shopp/exceptions/exceptions.dart';

class User {
    int user_id ;
    String email;
    String first_name;
    String last_name;
    String api_token;

    User(this.email, this.first_name, this.last_name,[this.api_token , this.user_id]);

     User.fromJson(Map<String, dynamic> jsonObject) {
       if(jsonObject['user_id'] == null){
         throw PropertyIsRequired('User ID');
       }
       if(jsonObject['first_name'] == null){
         throw PropertyIsRequired('First Name');
       }
       if(jsonObject['email'] == null){
         throw PropertyIsRequired('Email');
       }
       if(jsonObject['last_name'] == null){
         throw PropertyIsRequired('Last Name');
       }
       if(jsonObject['api_token'] == null){
         throw PropertyIsRequired('API Token');
       }

            this.user_id= jsonObject['user_id'];
            this.email = jsonObject['email'];
            this.first_name = jsonObject['first_name'];
            this.last_name = jsonObject['last_name'];
            this.api_token = jsonObject['api_token'];

    }


}