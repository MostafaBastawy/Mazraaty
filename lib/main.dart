import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mazraaty/cubits/Favourite_cubit/favourite_cubit.dart';
import 'package:mazraaty/cubits/filter_cubit/filter_cubit.dart';
import 'package:mazraaty/cubits/order_cubit/order_cubit.dart';
import 'package:mazraaty/cubits/places_cubit/places_cubit.dart';
import 'package:mazraaty/cubits/profile_cubit/profile_cubit.dart';
import 'package:mazraaty/cubits/settings_cubit/settings_cubit.dart';

import 'package:mazraaty/modules/auth_screens/login_screen.dart';
import 'package:mazraaty/modules/auth_screens/splash_screen.dart';
import 'package:mazraaty/shared/bloc_observer.dart';
import 'package:mazraaty/shared/constants.dart';

import 'cubits/auth_cubit/auth_cubit.dart';
import 'cubits/home_cubit/home_cubit.dart';
import 'networks/local/cache_helper.dart';
import 'networks/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  ErrorWidget.builder = ((details){
    return Material(
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error,color: Colors.white,),
            Text("error",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),)
          ],
        ),
      ),
    );
  });
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kAppColor,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  BlocOverrides.runZoned(
        () => runApp(

        EasyLocalization(
            path: "assets/language",
            saveLocale: true,
            startLocale: Locale('ar',),
            fallbackLocale: Locale(
              'en',),
            supportedLocales: [
              const Locale('en', ''),
              const Locale('ar', ''),
            ],
            child: Phoenix(child: MyApp()))),
    blocObserver: MyBlocObserver(),
  );


}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider(
          create: (context) => PlacesCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
      ],
      child:StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          initialData: ConnectivityResult.wifi,
          builder:(context, snapshot){
            return MaterialApp(
              title: 'Stayat',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  fontFamily: "FFShamelFamily-SansOneBook"
              ),
              builder: (context,child){
                if(snapshot.data == ConnectivityResult.mobile ||
                    snapshot.data == ConnectivityResult.wifi) {
                  return child!;
                } else {
                  return Material(
                    child: Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/logo.png"),
                              SizedBox(height: 20,),
                              Text("noInternetConnection".tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                        )
                    ),
                  );
                }
              },
home: SplashScreen(),            );
          }
      ),
    );
  }
}


