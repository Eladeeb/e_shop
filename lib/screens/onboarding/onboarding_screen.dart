import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'package:e_shopp/screens/utlities/size_config.dart';
class SingleOnBoarding extends StatelessWidget {

  final OnBoardingModel onBoardingModel ;

  SingleOnBoarding(this.onBoardingModel);
  ScreenConfig screenConfig;
  WidgetSize widgetSize ;


  @override
  Widget build(BuildContext context) {
     screenConfig = ScreenConfig(context) ;
     widgetSize = WidgetSize(screenConfig);
    return Column(
      children: <Widget>[
        SizedBox(height: widgetSize.imageSizeBox,),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.85,
          height: MediaQuery.of(context).size.height* .50,
          child: Image(
            fit: BoxFit.cover,
            image: ExactAssetImage(onBoardingModel.image),
          ),
        ),
        Text(onBoardingModel.title,style: TextStyle(
          fontSize: widgetSize.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left:10,right: 20),
          child: Text(onBoardingModel.description,style: TextStyle(
            fontSize: widgetSize.descriptionFontSize,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
    ),
            textAlign: TextAlign.center,
    ),
        ),
      ],
    );
  }
}
