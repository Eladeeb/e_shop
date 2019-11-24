import 'package:e_shopp/screens/login.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/utlities/screen_utilities.dart';
void main() async{
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  bool islogged = pref.getBool('login');
  Widget homePage=HomePage();
  if(islogged == null || !islogged )
    {
      homePage = LoginScreen();

      if(isSeen == null || !isSeen ){
        homePage=OnBoarding();
      }

    }

  runApp(GeneralShop(homePage));
}
class GeneralShop extends StatelessWidget {
  final Widget homePage ;

  GeneralShop(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
        headline: TextStyle(
          fontSize: 16,
        color: ScreenUtilities.textColor,
        fontFamily: 'QuicKsand',
        fontWeight: FontWeight.w700,
         ),
          subhead:  TextStyle(
            fontSize: 15,
            color: ScreenUtilities.textColor,
            fontFamily: 'QuicKsand',
            fontWeight: FontWeight.w700,
          ),
        ),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          actionsIconTheme: IconThemeData(color: ScreenUtilities.textColor,),
          textTheme: TextTheme(
          //  title: TextStyle(
            //  fontSize: 22,
              //color: ScreenUtilities.textColor,
              //fontFamily: 'QuicKsand',
              //fontWeight: FontWeight.w700,
           // ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(
            fontFamily: "QuicKsand",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          labelPadding: EdgeInsets.only(left: 8 ,top: 12,bottom: 12,right: 8),
          indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: ScreenUtilities.unSelected,
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: "QuicKsand",
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ScreenUtilities.mainBlue ,
        ),
      ),


    );
  }

}

