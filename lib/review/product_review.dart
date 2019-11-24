import 'package:e_shopp/exceptions/exceptions.dart';
import 'reviewer.dart';
class ProductReview{
  String review ;
  int review_id , stars ;
  Reviewer reviewer ;



  ProductReview.fromJson(Map<String,dynamic> jsonObject){
    if(jsonObject['review_id'] == null){
      throw PropertyIsRequired('Review ID');
    }
    if(jsonObject['stars'] == null){
      throw PropertyIsRequired('Srars ');
    }
    if(jsonObject['review'] == null){
      throw PropertyIsRequired('Review');
    }
    if(jsonObject['reviewer'] == null){
      throw PropertyIsRequired('Reviewer');
    }
    this.review_id = jsonObject['review_id'];
    this.stars= jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer= Reviewer.fromJson( jsonObject['reviewer']);
  }
}