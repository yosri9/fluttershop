import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generalsop/api/helpers_api.dart';
import 'package:generalsop/product/home_product.dart';
import 'package:generalsop/product/product.dart';
import 'package:generalsop/product/product_category.dart';
import 'package:generalsop/screens/utilities/helpers_widgets.dart';
import 'package:generalsop/screens/utilities/screen_utilities.dart';
import 'package:generalsop/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;

  HelpersApi helpersApi = HelpersApi();
  HomeProductBloc homeProductBloc = HomeProductBloc();

  List<ProductCategory> productsCategories;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
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
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return error(snapshot.error.toString());
            } else {
              if (!snapshot.hasData) {
                return error("No data found");
              } else {
                this.productsCategories = snapshot.data;
                homeProductBloc.fetchProduct.add(this.productsCategories[0].category_id);
                return _screen(snapshot.data);
              }
            }

            break;
        }

        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories) {
    tabController =
        TabController(initialIndex: 0, length: categories.length, vsync: this);
    return Scaffold(
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
            controller: tabController,
            isScrollable: true,
            tabs: _tabs(categories),
            onTap: (int index) {
              homeProductBloc.fetchProduct.add( this.productsCategories[index].category_id );
            }
        ),
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
                      return _drawProducts(snapshot.data);
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

  Widget _drawProducts(List<Product> products) {
    return Container(
      child: Column(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: ( context, position){
              return Flexible(
                child: Card(
                  child: Image(
                    image: NetworkImage(products[position].featuredImage()),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
