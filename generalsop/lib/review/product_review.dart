import 'package:generalsop/exceptions/exception.dart';
import 'package:generalsop/review/reviewer.dart';

class ProductReview{
  int review_id;
  int stars;
  String review;
  Reviewer reviewer;

  ProductReview(this.review_id, this.stars, this.review, this.reviewer);

  ProductReview.fromJson(Map<String,dynamic>jsonObject){
    assert( jsonObject['review_id'] != null ,'Review Id is null');
    assert( jsonObject['stars'] != null ,'Stars is null');
    assert( jsonObject['review'] != null ,'Review  is null');
    assert( jsonObject['reviewer'] != null ,'Reviewer  is null');

    if( jsonObject['review_id'] ==null ){
      throw PropertyRequired('Review ID');
    }
    if( jsonObject['stars'] == null ){
      throw PropertyRequired('Stars');
    }
    if( jsonObject['review'] == null ){
      throw PropertyRequired('Review');
    }
    if( jsonObject['reviewer'] == null ){
      throw PropertyRequired('Reviewer');
    }



    this.review_id = jsonObject['review_id'];
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  }


}