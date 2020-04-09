import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey=GlobalKey<FormState>();

  File _image;
  File _image1,_image2,_image3;


  TextEditingController _productTitleController=TextEditingController();
  TextEditingController _productDescriptionController=TextEditingController();
  TextEditingController _priceController= TextEditingController();


  String selectedValue ='Select Category';
  bool isError=false;


  Future getImage(File requiredImage) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      requiredImage = image;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _productTitleController.dispose();
    _productDescriptionController.dispose();
    _priceController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),

      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child:Form(
          key:_formKey ,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _productTitleController,
                decoration: InputDecoration(
                  hintText: 'Product Title'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24,),
              TextFormField(
                controller: _productDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Product Description'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24,),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                    hintText: 'Product Price'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
               SizedBox(
                 width: double.infinity,
                 child: _selectCategory(),
               ),

              _displayImagesGrid(),

              SizedBox(height: 32),
              RaisedButton(
                color: Colors.teal,
                  child: Text('Save Product',style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      String imageUrl1= await uploadImage(_image1);
                      String imageUrl2= await uploadImage(_image2);
                      String imageUrl3= await uploadImage(_image3);

                      List<String> images=[imageUrl1,imageUrl2,imageUrl3];

                      await Firestore.instance.collection('products').document()
                          .setData({
                        'product_title': _productTitleController.text,
                        'product_description': _productDescriptionController.text ,
                        'product_price':_priceController.text,
                        'category_title' : selectedValue,
                        'images':images
                          });


                     await uploadImage(_image1);
                     await uploadImage(_image2);
                     await uploadImage(_image3);

                    }
                  }
                  ),
              SizedBox(height: 32,),
              SizedBox(
                width: double.infinity,
                child: (isError)? Text('Error Selecting Category',style: TextStyle(color: Colors.red),): Container() ,
              )
            ],
          ),
        )

      ),
    );
  }
  Future <String> uploadImage(File image)async{
    String name= Random().nextInt(10000).toString()+'_product';
    final StorageReference storageReference = FirebaseStorage().ref().child(name);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot response= await uploadTask.onComplete;
    String url= await response.ref.getDownloadURL();
    return url;
  }

  Widget _displayImagesGrid() {
    return  Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: ()async{
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  _image1 = image;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal,
              ),
            ),
            InkWell(
              onTap: ()async{
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  _image2 = image;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal,
              ),
            ),InkWell(
              onTap: ()async{
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  _image3 = image;
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal,
              ),
            ),
          ],
        )

        ]
    );


  }


  Widget _selectCategory() {
    return StreamBuilder(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return DropdownButton<String>(

              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.deepPurple
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                if(newValue=='Select Category'){
                  setState(() {
                    isError=true;
                  });
                }else{
                  setState(() {
                    selectedValue=newValue ;
                    isError=false;
                  });
                }


              },
              value:selectedValue,
              items: snapshot.data.documents.map((DocumentSnapshot document) {
                return DropdownMenuItem<String>(
                  value: document['title'],
                  child: Text(document['title']),
                );
              }).toList()
            );
        }
      }
      );
  }
}