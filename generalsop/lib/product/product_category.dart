import 'package:generalsop/exceptions/exception.dart';

class ProductCategory{
  int category_id;
  String category_name;
  String image_direction;
  String image_url;


  ProductCategory(this.category_id, this.category_name, this.image_direction,
      this.image_url);

  ProductCategory.fromJson(Map<String,dynamic>jsonObject){
    assert( jsonObject['category_id'] !=null , 'Category ID is null' );
    assert( jsonObject['category_name'] !=null , 'Category Name is null' );
    assert( jsonObject['image_direction'] !=null , 'Image Direction ID is null' );
    assert( jsonObject['image_url'] !=null , 'Image Url is null' );

    if(jsonObject['category_id']==null){
      throw PropertyRequired('Category ID');
    }
    if(jsonObject['category_name']){
      throw PropertyRequired('Category Name');
    }
    if(jsonObject['image_direction']){
      throw PropertyRequired('Image Direction');
    }
    if(jsonObject['image_url']){
      throw PropertyRequired('Image Url');
    }
    this.category_id=jsonObject['category_id'];
    this.category_name=jsonObject['category_name'];
    this.image_direction=jsonObject['image_direction'];
    this.image_url=jsonObject['image_url'];

  }

}