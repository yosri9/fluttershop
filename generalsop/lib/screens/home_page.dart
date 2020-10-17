import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generalsop/api/helpers_api.dart';
import 'package:generalsop/product/home_product.dart';
import 'package:generalsop/product/product.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/screens/single_product.dart';
import 'package:generalsop/screens/streams/categories_stream.dart';
import 'package:generalsop/screens/streams/dots_stream.dart';
import 'package:generalsop/screens/utilities/helpers_widgets.dart';
import 'package:generalsop/screens/utilities/screen_utilities.dart';
import 'package:generalsop/screens/utilities/size_config.dart';

import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;

  PageController _pageController;
  HelpersApi helpersApi = HelpersApi();

  ValueNotifier<int> dotsIndex = ValueNotifier(1);

//  DotsStream  dotsStream = DotsStream();
  HomeProductBloc homeProductBloc = HomeProductBloc();
  CategoriesStream categoriesStream = CategoriesStream();

  ValueNotifier<int> dotIndex = ValueNotifier(1);

  List<ProductCategory> productsCategories;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
//    dotsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
      future: helpersApi.fetchCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductCategory>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return error("No connection made");
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.done:
          case ConnectionState.active:
            if (snapshot.hasError) {
              return error(snapshot.error.toString());
            } else {
              if (!snapshot.hasData) {
                return error("No data found");
              } else {
                this.productsCategories = snapshot.data;
                homeProductBloc.fetchProduct
                    .add(this.productsCategories[0].category_id);
                return _screen(snapshot.data, context);
              }
            }

            break;
        }

        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
    tabController =
        TabController(initialIndex: 0, length: categories.length, vsync: this);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('My Name'),
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
            ),
            ListTile(
              title: Text('Cart'),
              leading: Icon(Icons.card_travel),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute( builder: (context) => CartScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
              ),
              onPressed: () {},
            ),
          )
        ],
        bottom: TabBar(
            indicatorColor: ScreenUtilities.mainBlue,
            indicatorWeight: 3,
            controller: tabController,
            isScrollable: true,
            tabs: _tabs(categories),
            onTap: (int index) {
              homeProductBloc.fetchProduct
                  .add(this.productsCategories[index].category_id);
            }),
      ),
      body: Container(
        child: StreamBuilder(
            stream: homeProductBloc.productsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return error('Nothing is working');
                  break;

                case ConnectionState.waiting:
                  return loading();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return error(snapshot.error.toString());
                  } else {
                    if (!snapshot.hasData) {
                      return error('No Data');
                    } else {
                      return _drawProducts(snapshot.data, context);
                    }
                  }
                  break;
              }
              return Container();
            }),
      ),
    );
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];
    for (ProductCategory category in categories) {
      tabs.add(Tab(
        text: category.category_name,
      ));
    }
    return tabs;
  }

  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 5;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);

    for (int index in indexes) {
      newProducts.add(products[index]);
    }

    return newProducts;
  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: topProducts.length,
              onPageChanged: (int index) {
                dotsIndex.value=index;
              },
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: (){
                    _gotoSingleProduct(topProducts[position], context);
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 3, right: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      loadingBuilder: ( context , image , ImageChunkEvent loadingProgress){
                        if(loadingProgress == null){
                          return image;
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      fit: BoxFit.cover,
                      image:
                      NetworkImage(topProducts[position].featuredImage()),
                    ),
                  ),
                );
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: dotsIndex,
            builder: ( context , value , _){
              return Container(
                padding: EdgeInsets.only( top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawDots(topProducts.length, value)
                ),
              );
            },
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 24),
              child: GridView.builder(
                itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.55
                  ), itemBuilder: (context, position) {
                return InkWell(
                  onTap: (){
                    _gotoSingleProduct(products[position], context);
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            shape: BoxShape.rectangle
                          ),
                          child: Image(
                            loadingBuilder: ( context , image , ImageChunkEvent loadingProgress){
                              if(loadingProgress == null){
                                return image;
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            image: NetworkImage(
                                products[position].featuredImage()
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          products[position].product_title,
                          textAlign: TextAlign.center,
                          style:Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                         '\$ ${ products[position].product_price.toString()}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                    ],
                  ),
                );
              }
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qty , int index) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == index)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.lightGrey,
          ),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return widgets;
  }
  void _gotoSingleProduct( Product product , BuildContext context  ){
    Navigator.push(context, MaterialPageRoute(
      builder: ( context ){
        return SingleProduct( product );
      }
    ));
  }

}
