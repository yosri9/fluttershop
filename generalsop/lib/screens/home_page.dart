import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generalsop/api/helpers_api.dart';
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
  TabController tabController ;


  HelpersApi helpersApi =HelpersApi();
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0 ,
      vsync: this,
      length: 0,
    );
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    screenConfig =ScreenConfig(context);
    return FutureBuilder(
      future: helpersApi.fetchCategories(),
      builder: ( BuildContext context , AsyncSnapshot <List<ProductCategory>> snapshot){
        switch( snapshot.connectionState ){

          case ConnectionState.none:
            return error("No connection made");
            break;
          case ConnectionState.waiting:
          case ConnectionState.active:
          return loading();
           break;
          case ConnectionState.done:
            if( snapshot.hasError ){
              return error(snapshot.error.toString());
            }else{
              if( !snapshot.hasData){
                return error("No data found");
              }else{

                return _screen(snapshot.data);
              }
            }

            break;
        }

        return Container();
      },
    )  ;

  }
  Widget _screen(List<ProductCategory> categories){
    tabController = TabController(
      initialIndex: 0,
      length: categories.length,
      vsync: this
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',

        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only( right: 16 ),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
              ),
              onPressed: (){

              },
            ),
          )
        ],
        bottom: TabBar(
          indicatorColor: ScreenUtilities.mainBlue,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
        ),
        backgroundColor: Colors.white,

      ),
      body: Container(

      ),
    );

  }
  List<Tab> _tabs( List<ProductCategory> categories ){
    List<Tab> tabs = [];
    for ( ProductCategory category in categories ){
      tabs.add(
        Tab(
          text: category.category_name,

        )
      );
    }
  }

}
