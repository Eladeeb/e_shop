import 'package:e_shopp/api/authentication.dart';
import 'package:e_shopp/customer/user.dart';
import 'package:e_shopp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utlities/screen_utilities.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController =TextEditingController();
  Authentication authentication = Authentication();
  bool loginError = false ;
  var _formKey = GlobalKey<FormState>();
  bool _loading =false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Transform.translate(
            offset: Offset(0,10),
            child: Padding(
              padding: const EdgeInsets.only(right: 16,left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('Sign In',style: TextStyle(
                      fontSize: 35,
                      color: ScreenUtilities.textColor,
                      fontFamily: 'QuicKsand',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                     Text('Login to continue your account,',  style : TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: 'QuicKsand',
                      fontWeight: FontWeight.w700,
                    ),),


                  Padding(
                    padding: const EdgeInsets.only(top: 15 , bottom:  15),
                    child: _loginForm(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15 , bottom: 15),
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      color: ScreenUtilities.mainBlue,
                      onPressed: (_loading)?null : _loginUser,
                      child: (_loading) ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                      :Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 3
                        ),
                      ),


                    ),
                  ),
                  (loginError)?_drawLoading(): Container() ,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Don\'t have an account?',style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),),
                      Transform.translate(
                        offset: Offset(-5,0),
                        child: FlatButton(
                          child:
                         Text('Sign UP',style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                         ),),
                          onPressed: (){
                           // Navigator.push(context,
                            //MaterialPageRoute(context )=> )
                          },
                        ),

                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration:  InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                fontSize: 24,
              ),
            ),
            style:TextStyle(fontSize: 24) ,
            validator: (value){
              if(value.isEmpty)
                {
                  return 'Email is required';
                }
              return null ;
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value){
              if(value.isEmpty)
              {
                return 'Password is required';
              }
              return null ;
            },
            obscureText: true,
            decoration:  InputDecoration(
                hintText: 'Password',
              hintStyle: TextStyle(
                fontSize: 24,
              ),
            ),
            style:TextStyle(fontSize: 24) ,
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    if(_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      loginError =  preferences.getBool('login_error');
      User user = await authentication.login(email, password);
      if (user != null) {
        setState(() {
          _loading = false;

        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        bool isLogged = pref.getBool('login');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }else {
        _drawLoading() ;
      }
    }
  }
  Widget _drawLoading(){
    if(loginError){
      setState(() {
        _loading = false;
      });
      return Container(
        child:  Center(
          child: Text('Login Error',style: TextStyle(
            color: Colors.red,
            fontSize: 22
          ),),
        ),
      );
    }
  }
}
