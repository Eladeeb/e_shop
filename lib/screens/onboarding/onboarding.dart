import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';
import 'package:e_shopp/screens/utlities/screen_utilities.dart';
import 'package:e_shopp/screens/utlities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_shopp/screens/home_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController ;
  int currentIndex =0 ;
  bool lastPage = false ;
  List<OnBoardingModel>screens=[
    OnBoardingModel(image:'assets/images/onboarding1.jpg',
        title: 'Welcome!',
        description: "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we Brady Bunch.."),
     OnBoardingModel(image:'assets/images/onboarding2.jpg',
        title: 'Add To Cart!',
        description: "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we Brady Bunch.."),
     OnBoardingModel(image:'assets/images/onboarding3.jpg',
        title: 'Enjoy Purchase!',
        description: "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we Brady Bunch.."),
  ];

  @override
  void initState() {
    super.initState();
    _pageController =PageController(
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
    ScreenConfig screenConfig = ScreenConfig(context) ;
    return Scaffold(
      body:
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: screens.length,
                      itemBuilder: (BuildContext context , int position){
                        return SingleOnBoarding(screens[position]);
                      },
                      onPageChanged: (int position){
                        setState(() {
                          currentIndex = position ;
                          if(currentIndex == screens.length-1){
                            lastPage = true ;
                          }else{lastPage = false;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(screenConfig.width,screenConfig.height),
                  child: Container(
                    child: Row(
                      children:_drawDots(screens.length),

                    ),
                  ),
                ),
                (lastPage)?_showButton():Container(),
              ],
            ),
          )

    );
  }
  Widget _showButton(){
    ScreenConfig screenConfig = ScreenConfig(context) ;
    WidgetSize widgetSize =WidgetSize(screenConfig);
    return Container(
      child: Transform.translate(
        offset: Offset(0,-30),
        child: SizedBox(
          height: widgetSize.buttonSize,
          width: MediaQuery.of(context).size.width*.75,
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            color: ScreenUtilities.mainBlue,
            onPressed: ()async{
              var pref = await SharedPreferences.getInstance();
              pref.setBool('is_seen', true);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>HomePage()),
              );
            },
            child: Text(
              "START",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widgetSize.buttonFontSize,
                  letterSpacing: 3
              ),
            ),

          ),
        ),
      ),
    );
  }
  List<Widget> _drawDots(int qty){
    List<Widget> widgets =[];
    for(int i =0 ;i<qty;i++)
      {
        widgets.add(
            Padding(
              padding: const EdgeInsets.only(right: 5,left: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ((i == currentIndex)? ScreenUtilities.mainBlue : ScreenUtilities.lightGrey),
                ),
                width: 30,
                height: 5,
              ),
            ),
        );
      }
    return widgets ;
  }
}
