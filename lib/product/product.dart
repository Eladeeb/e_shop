import 'product_unit.dart';
import 'product_category.dart';
import 'product_tag.dart';
import 'package:e_shopp/review/product_review.dart';
import 'package:e_shopp/exceptions/exceptions.dart';
class Product{
  int product_id ;
  String  product_title,product_description,product_specifications,product_info,product_name ;
  ProductUnit productUnit ;
  double  product_price,product_total,product_discount;
  ProductCategory productCategory ;
  List<ProductTag> tags ;
  List<String> images ;
  List<ProductReview> reviews ;


  Product(this.product_id, this.product_title, this.product_description,
      this.productUnit, this.product_price, this.product_total,
      this.product_discount, this.productCategory, this.tags, this.images,
      this.reviews ,this.product_name,this.product_info,this.product_specifications);

  Product.fromJson(Map<String,dynamic> jsonObject){

    if(jsonObject['product_title'] == null){
      throw PropertyIsRequired('product_title');
    }
    if(jsonObject['product_id'] == null){
      throw PropertyIsRequired('product_id');
    }
    if(jsonObject['product_description'] == null){
      throw PropertyIsRequired('product_description');
    }
    if(double.tryParse(jsonObject['product_price']) == null ){
      throw PropertyIsRequired('product_price');
    }
    if(jsonObject['product_name'].toString() == null){
      throw PropertyIsRequired('product_name');
    }
    if(jsonObject['product_info'].toString() == null){
      throw PropertyIsRequired('product_infooo');
    }
    if(jsonObject['product_specifications'].toString() == null ){
      throw PropertyIsRequired('product_specifications');
    }
    this.product_name=jsonObject['product_name'].toString();
    this.product_info =jsonObject['product_info'].toString();
    this.product_specifications=jsonObject['product_specifications'].toString();
    this.product_title = jsonObject['product_title'];
    this.product_id = jsonObject['product_id'];
    this.product_description = jsonObject['product_description'];
    this.product_discount = double.tryParse(jsonObject['product_discount']);
    this.product_price =double.tryParse(jsonObject['product_price']);
    this.product_total =double.tryParse(jsonObject['product_total']);
    this.productCategory= ProductCategory.fromJson(jsonObject['product_category']);
   // this.productUnit = ProductUnit.fromJson(jsonObject['product_unit']);
    _setTags(jsonObject['product_tags']);
    _setImages(jsonObject['product_images']);
    _setreviews(jsonObject['product_review']);
  }

  void _setreviews(List<dynamic> jsonObjects){
    this.reviews =[];
    for(var review in jsonObjects){
      this.reviews.add(ProductReview.fromJson(review));
    }
  }
  
  void _setTags(List<dynamic> jsonTags){
    this.tags =[];
    for(var tag in jsonTags){
      this.tags.add(ProductTag.fromJson(tag));
    }
  }

  void _setImages(List<dynamic> jsonImages){
    this.images=[];
    for(var image in jsonImages){
      this.images.add(image['image_url']);
    }
  }
  String featuredImage(){
    if(this.images.length>0){
      return this.images[0];
    }
    return 'https://www.joggen-online.de/sport/GYXIN/GYXIN-Men-es-Hoodie-Fashion-Suicide-Squad-Joker-Hoodie-Men-Women-Long-Sleeve-Outerwear-Print-3D-Sweatshirt-Crewneck-Casual-Pullover,M-von-GYXIN-621995397.jpg';

  }


}