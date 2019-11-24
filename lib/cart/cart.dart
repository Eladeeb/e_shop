import 'package:e_shopp/product/product.dart';
import 'package:e_shopp/exceptions/exceptions.dart';

class CartItem{
  Product product ;
  double qty ;

  CartItem(this.product, this.qty);

  CartItem.fromJson(Map<String,dynamic> jsonObject){
    if(jsonObject['qty'] == null){
      throw PropertyIsRequired('qty');
    }
    this.product = Product.fromJson(jsonObject['product']);

    this.qty =double.tryParse(jsonObject['qty']);
  }
}
class Cart{
  List<CartItem> cartItems ;
  int id ;
  double total ;

  Cart(this.cartItems, this.id, this.total);

  Cart.fromJson(Map<String,dynamic> jsonObject)
  {
    _setCartItem(jsonObject['cart_items']);

    this.id=jsonObject['id'];
    this.total=jsonObject['total'];

  }
  void _setCartItem(List<dynamic> jsonItems){
    this.cartItems =[];
    for(var item in jsonItems){
      this.cartItems.add(CartItem.fromJson(item));
    }
  }
}