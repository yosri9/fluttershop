import 'package:flutter/material.dart';
import 'package:generalsop/screens/onboarding/onboarding_model.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel;

  const SingleOnBoarding( {Key key, this.onBoardingModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            fontSize: 28,
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
                fontSize: 20 ,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey
              ),
          ),
        ),
      ],
    );
  }
}
