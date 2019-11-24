import 'package:e_shopp/exceptions/exceptions.dart';

import 'api_util.dart';
import 'package:e_shopp/product/product.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class ProductsAPI{
  Map<String,String> headers ={
    'Accept' : 'application/json'
  };
  String url = 'http://10.0.2.2:8000/api/products';
  Future<List<Product>> fetchProducts(int page)async{
    String URL = url+'?page='+page.toString();
    http.Response response = await http.get(URL, headers:  headers) ;
    List<Product> products =[];
    if(response.statusCode == 200)
      {
        var body = jsonDecode(response.body );
        var data =body['data'];
        for(var item in data)
          {
          products.add(
                Product.fromJson(item)
            );

          }
        return products ;

      }
    return null ;


  }
  Future<List<Product>> fetchProductsByCategory(int category ,int page)async{
    String a ='http://10.0.2.2:8000/api/categories/'+category.toString()+'/products?page='+page.toString();
    http.Response response = await http.get(a, headers:  headers) ;
    List<Product> products =[];
    switch(response.statusCode){
      case 404:
        throw ResourceNotFound('Products');
        break ;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break ;
      case 200:

        var body = jsonDecode(response.body );
        var data =body['data'];
        for(var item in data)
        {
          products.add(
              Product.fromJson(item)
          );

        }
        return products ;
        break ;
      default:
        return null ;
        break;
    }

  }

  Future<Product> fetchProduct(int id)async{
    String URL = url+'/'+id.toString();
    http.Response response = await http.get(URL, headers:  headers) ;
    if(response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Product.fromJson(body['data']);
    }
    return null ;
  }


}