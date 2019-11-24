import 'package:flutter/material.dart';
enum ScreenType{
  SMALL , MEDIUM ,LARGE ,XLARGE
}
class ScreenConfig{
BuildContext context ;
double screenWidth ,screenHeight ;
ScreenType screenType ;
double width ;
double height;

ScreenConfig(this.context){
  this.screenHeight=MediaQuery.of(context).size.height;
  this.screenWidth=MediaQuery.of(context).size.width;
  this.width=MediaQuery.of(context).size.width*.3;
  this.height=-MediaQuery.of(context).size.height*.12;
  _setScreeen();
}

  void _setScreeen() {
  if( this.screenWidth<500)
    {
      this.screenType =ScreenType.SMALL ;
    }
  if(this.screenWidth>=500&& this.screenWidth<720)
  {
    this.screenType =ScreenType.MEDIUM ;
  }
  if(this.screenWidth>=720&& this.screenWidth<1080)
  {
    this.screenType =ScreenType.LARGE ;
  }
  if(this.screenWidth>=180)
  {
    this.screenType =ScreenType.SMALL ;
  }
  }

}
class WidgetSize{
  double titleFontSize,descriptionFontSize,imageSizeBox,textSizeBox,buttonSize,buttonFontSize;
  ScreenConfig screenConfig ;
  WidgetSize(this.screenConfig){
    _init();
  }

  void _init() {
    switch(this.screenConfig.screenType){
      case ScreenType.SMALL :
        this.buttonSize =40;
        this.buttonFontSize=18;
        this.titleFontSize = 20 ;
        this.imageSizeBox =16;
        this.textSizeBox=5;
        this.descriptionFontSize =15;
        break ;
      case ScreenType.MEDIUM :
        this.buttonFontSize=20;
        this.buttonSize =50;
        this.textSizeBox=10;
        this.titleFontSize = 18 ;
        this.imageSizeBox =20;
        this.descriptionFontSize =15;

        break ;
      case ScreenType.LARGE :
        this.buttonFontSize=20;
        this.buttonSize =55;
        this.textSizeBox=10;
        this.titleFontSize = 20 ;
        this.imageSizeBox =25;
        this.descriptionFontSize =18;
        break ;
      case ScreenType.XLARGE :
        this.buttonFontSize=22;
        this.buttonSize =60;
        this.textSizeBox=15;
        this.imageSizeBox =30;
        this.titleFontSize = 22 ;
        this.descriptionFontSize =20;
        break ;
    }
  }


}