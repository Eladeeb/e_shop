import 'package:e_shopp/exceptions/exceptions.dart';
class ProductCategory{
  int category_id;
  String category_name,image_direction,image_url ;


  ProductCategory.fromJson(Map<String,dynamic> jsonObject){
    if(jsonObject['category_id'] == null){
      throw PropertyIsRequired('Category ID');
    }
    if(jsonObject['category_name'] == null){
      throw PropertyIsRequired('Category Name');
    }
    if(jsonObject['image_direction'] == null){
      throw PropertyIsRequired('Image Direction');
    }
    if(jsonObject['image_url'] == null){
      throw PropertyIsRequired('Image Direction');
    }
    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
    this.image_direction = jsonObject['image_direction'];
    this.image_url= jsonObject['image_url'];
  }

}