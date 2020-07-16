class ProductTag{
  int tag_id;
  String tag_name;

  ProductTag(this.tag_id, this.tag_name);
  ProductTag.fronJson(Map<String,dynamic>jsonObject){
    if(jsonObject['tag_id']==null){
      throw('Tag ID');
    }
    if(jsonObject['Tag Name']){
      throw('Tag Name');
    }
    this.tag_id=jsonObject['tag_id'];
    this.tag_name=jsonObject['tag_name'];
  }

}