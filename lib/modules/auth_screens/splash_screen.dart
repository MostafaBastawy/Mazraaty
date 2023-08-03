import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mazraaty/shared/components.dart';
import '../../layout/home_layout.dart';
import 'login_screen.dart';
import '../../networks/local/cache_helper.dart';
import '../../shared/constants.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3),(){
      if(CacheHelper.getData("userToken") == null){
        // if(CacheHelper.getData("userLanguage") ?? false)
        //   {
            navigateAndFinish(context,LoginScreen());
          // }else{
          // navigateAndFinish(context,LanguageScreen());
        //}
      }else{
        navigateAndFinish(context,HomeLayout());
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
           color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Image.asset("assets/images/logo.png",width: 200,)),
        ),
      ),
    );
  }
}
