import 'dart:core';
import 'dart:core';

import 'package:generalsop/exceptions/exception.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/product/product_tag.dart';
import 'package:generalsop/product/product_unit.dart';
import 'package:generalsop/review/product_review.dart';

class Product {
  int product_id;
  String product_title;
  String product_description;
  ProductUnit productUnit;
  double product_price;
  double product_total;
  double product_discount;
  ProductCategory productCategory;
  List<ProductTag> tags;
  List<String> images;
  List<ProductReview> reviews;

  Product(
      this.product_id,
      this.product_title,
      this.product_description,
      this.productUnit,
      this.product_price,
      this.product_total,
      this.product_discount,
      this.productCategory,
      this.tags,
      this.images,
      this.reviews);

  Product.fromJson(Map<String,dynamic> jsonObject) {
    assert(jsonObject['product_id']!=null,'Product ID is null');
    assert(jsonObject['product_title']!=null,'Product title is null');
    assert(jsonObject['product_descrption']!=null,'Product description is null');
    assert(jsonObject['product_price']!=null,'Product price is null');

    if(jsonObject['product_id']==null){
      throw PropertyRequired('Product ID');
    }
    if(jsonObject['product_title']==null){
      throw PropertyRequired('Product Title');
    }
    if(jsonObject['product_descrption']==null){
      throw PropertyRequired('Product Description');
    }
    if(jsonObject['product_price']==null){
      throw PropertyRequired('Product price');
    }


    this.product_id = jsonObject['product_id'];

    this.product_title = jsonObject['product_title'];

    this.product_description = jsonObject['product_description'];

    if(jsonObject['product_unit']!=null){
      this.productUnit = jsonObject['product_unit'];
    }

    this.product_price = double.tryParse(jsonObject['product_price']);
    this.product_total = double.tryParse(jsonObject['product_total']);


    this.product_discount = double.tryParse(jsonObject['product_discount']);

    this.productCategory =
        ProductCategory.fromJson(jsonObject['product_category']);
    this.tags = [];
    if(jsonObject['product_tags']==null){
      _setTags(jsonObject['product_tags']);
    }

    if (jsonObject['product_tags'] != null) {
      _setTags(jsonObject['product_tags']);
    } else {

    }
    this.images = [];
    if(jsonObject['product_images']!=null){
      _setImages(jsonObject['product_images']);
    }
    this.reviews = [];
    if (jsonObject['product_reviews'] != null) {
      _setReviews(jsonObject['product_reviews']);
    } else {
    }

  }
  void _setReviews(List<dynamic> reviewsJson){
    if(reviewsJson.length!=null && reviewsJson.length>0) {
      for (var item in reviewsJson) {
        if (item != null) {
          this.reviews.add(ProductReview.fromJson(item));
        }
      }
    }
  }
  void _setTags(List<dynamic> tagsJson){
    if(tagsJson.length!=null && tagsJson.length>0 ){
      for (var item in tagsJson){
        if(item!=null){
          tags.add(ProductTag.fronJson(item));

        }
      }
    }

  }
  void _setImages(List<dynamic> jsonImages) {
    if(jsonImages.length!=null && jsonImages.length>0 ){
      for (var image in jsonImages) {
        if(image!=null){
          this.images.add(image['image_url']);
        }
      }
    }

  }
  String featuredImage(){
    if( this.images.length >0){
      return this.images[0];
    }
  }
}
