import 'package:e_shopp/customer/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_util.dart';
import 'dart:convert';
import 'package:e_shopp/exceptions/exceptions.dart';
class Authentication{
  Map<String,String> headers ={
    'Accept' : 'application/json'
  };
   Future<User> register(String first_name , String last_name , String email , String password ) async{

     Map<String,String> body ={
       'first_name' : first_name,
       'last_name' : last_name ,
       'email' : email ,
       'password' : password ,
     };
     http.Response response = await http.post(ApiUtl.AUTH_REGISTER , headers: headers ,body: body );
     switch(response.statusCode){
       case 201 :
         var body = jsonDecode(response.body );
         var data =body['data'];
         return User.fromJson(data);
         break ;
       case 422 :
         throw UnprocessedEntity();
         break ;
        default :
     return null ;
     }

  }
   Future<User> login(String email ,String password) async{
     Map<String,String> body ={

       'email' : email ,
       'password' : password ,
     };
     http.Response response = await http.post(ApiUtl.AUTH_LOGIN , headers: headers ,body: body );
     switch(response.statusCode ){
       case 200 :
         var body = jsonDecode(response.body );
         var data =body['data'];
         User user = User.fromJson(data);
         await _saveUser(user.user_id,user.api_token);
         return user ;
         break ;
       case 422 :
         throw UnprocessedEntity();
         break ;
       case 401:
         SharedPreferences preferences = await SharedPreferences.getInstance();
         bool x = await preferences.setBool('login_error', true);
         break ;
       case 404 :
         throw ResourceNotFound('User');
         break ;
       default :
         return null ;
         break ;

     }
  }
  Future<void> _saveUser(int userID,String apiToken)async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setInt('user_id', userID);
     bool isLogged = await pref.setBool('login', true);
     pref.setString('api_token', apiToken);
  }

}