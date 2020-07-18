import 'package:flutter/material.dart';
import 'package:generalsop/screens/onboarding/onboarding_model.dart';
import 'package:generalsop/screens/utilities/size_config.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  ScreenConfig screenConfig;
  WidgetSize widgetSize;

   SingleOnBoarding( {Key key, this.onBoardingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image(
            image: ExactAssetImage(
              onBoardingModel.image
            ),
          ),
        ),
        SizedBox(height: 24,),

        Text(
          onBoardingModel.title ,
          style: TextStyle(
            height: 1.5,
            fontSize: widgetSize.titleFontSize,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 24,),
        Padding(
          padding: const EdgeInsets.only( left: 22 , right: 22 ),
          child: Text(
              onBoardingModel.description,
              textAlign: TextAlign.center ,
              style: TextStyle(
                height: 1.5 ,
                fontSize: widgetSize.descriptionFontSize ,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey
              ),
          ),
        ),
      ],
    );
  }
}
