import 'package:flutter/material.dart';
import 'package:generalsop/screens/onboarding/onboarding_model.dart';
import 'package:generalsop/screens/onboarding/onboarding_screen.dart';
import 'package:generalsop/screens/onboarding/utilities/screen_utilities.dart';

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
    return    Container(
      child: Transform.translate(
        offset: Offset(0, -screenHeight * 0.1),
        child: SizedBox(
          width: screenWidth * 0.75,
          height: 48,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34)),
            color: ScreenUtilities.mainBlue,
            onPressed: () {},
            child: Text('START',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
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
          width: 35,
          height: 6,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return widgets;
  }
}
