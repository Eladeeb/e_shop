import 'package:e_shopp/api/cart_api.dart';
import 'package:e_shopp/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'utlities/helpers_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}
CartApi cartApi =CartApi();
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:  true,
        title: Text('Cart'),

      ),
      body: FutureBuilder(
        future: cartApi.fetchCard(),
        builder:(BuildContext context ,AsyncSnapshot<Cart> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return error("No connection made");
              break;
            case ConnectionState.active :
            case ConnectionState.waiting:
              return loading();
              break ;
            case ConnectionState.done:
              if(snapshot.hasError){
                return error(snapshot.error.toString());
              }else{
                if( !snapshot.hasData){
                  return error("No Data Found");
                } else{
                  return ListView.builder(
                    itemCount: snapshot.data.cartItems.length,
                      itemBuilder: (context ,int poistion){
                    return ListTile(
                      title: Text(snapshot.data.cartItems[poistion].product.product_name),
                      trailing: Text(snapshot.data.cartItems[poistion].qty.toString()),
                    );
                  });
                }
              }
              break ;
            default:
              return Container();
              break ;
          }
          return null;
        },
      ),
    );

  }
}
