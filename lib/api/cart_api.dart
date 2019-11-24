import 'dart:convert';
import 'dart:io';

import 'package:e_shopp/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:e_shopp/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartApi{



  String url = 'http://10.0.2.2:8000/api/carts';
  Future<Cart> fetchCard()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken =sharedPreferences.getString('api_token');
    Map<String,String> authHeaders ={
      'Accept' : 'application/json',
      'Authorization': 'Bearer ' +apiToken,
    };
    http.Response response = await http.get(url, headers:  authHeaders) ;
    switch(response.statusCode ){
      case 200 :
        var body = jsonDecode(response.body );
        return Cart.fromJson(body);
        break ;
      case 422 :
        throw UnprocessedEntity();
        break ;
      case 401:
        throw UnprocessedEntity();
        break ;
      case 404 :
        throw ResourceNotFound('User');
        break ;
      default :
        return null ;
        break ;

    }
  }

  Future<bool> addProductToCart(int productID)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken =sharedPreferences.getString('api_token');
    Map<String,String> authHeaders ={
      'Accept' : 'application/json',
      'Authorization': 'Bearer ' +apiToken,
    };

    Map<String,dynamic> body ={
      'product_id' : productID.toString(),
      'qty' : 1.toString() ,

    };
    http.Response response = await http.post(url, headers:  authHeaders,body: body ) ;
    switch(response.statusCode ){

      case 200 :
      case 201 :
        return true ;
        break ;
      case 422 :
        throw UnprocessedEntity();
        break ;
      case 401:
        throw UnprocessedEntity();
        break ;
      case 404 :
        throw ResourceNotFound('User');
        break ;


    }
  }
}