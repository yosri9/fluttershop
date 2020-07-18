import 'package:flutter/material.dart';
import 'package:generalsop/screens/home_page.dart';
import 'package:generalsop/screens/onboarding/onboarding_model.dart';
import 'package:generalsop/screens/onboarding/onboarding_screen.dart';

import 'package:generalsop/screens/utilities/screen_utilities.dart';
import 'package:generalsop/screens/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double screenWidth;
  double screenHeight;
  int currentIndex = 0;
  bool lastPage =false;

  PageController _pageController;
  List<OnBoardingModel> screens = [
    OnBoardingModel(
        image: "assets/images/1.png",
        title: "welcome!",
        description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
    OnBoardingModel(
        image: "assets/images/2.png",
        title: "Add to cart",
        description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
    OnBoardingModel(
        image: "assets/images/3.png",
        title: "Enjoy Purchase",
        description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
  ];
  ScreenConfig screenConfig;
  WidgetSize widgetSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     screenConfig = ScreenConfig(context);
     widgetSize = WidgetSize(screenConfig);
    print(screenConfig.screenType);
    print(screenConfig.screenWidth);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    double _mt = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: _mt),
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: PageView.builder(
                controller: _pageController,
                itemCount: screens.length,
                itemBuilder: (BuildContext context, int position) {
                  return SingleOnBoarding(onBoardingModel: screens[position]);
                },
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                    if( index == screens.length-1 ){
                      lastPage = true;
                    }else{
                      lastPage = false;
                    }
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(screenHeight * 0.15)),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _drawDots(screens.length),
              ),
            ),
          ),
          ( lastPage ) ? _showButton() : Container(),
        ],
      ),
    );
  }

  Widget _showButton(){
    double offset = ( screenConfig == ScreenType.SMALL ) ? 0.05 : 0.1;
    return    Container(
      child: Transform.translate(
        offset: Offset(0, -( offset*screenHeight )),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: widgetSize.buttonHeight,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34)),
            color: ScreenUtilities.mainBlue,
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              pref.setBool('is_seen', true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('START',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: widgetSize.buttonFontSize,
                    letterSpacing: 3)),
          ),
        ),
      ),
    ) ;
  }


  List<Widget> _drawDots(int qty) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == currentIndex)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.lightGrey,
          ),
          width: widgetSize.pagerDotsWidth,
          height: widgetSize.pagerDotsHeight,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return widgets;
  }
}
