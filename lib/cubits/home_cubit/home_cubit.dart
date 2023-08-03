import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/models/notifications_model.dart';
import 'package:mazraaty/models/sliders_model.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../models/home_model.dart';
import '../../networks/local/cache_helper.dart';
import '../../networks/remote/dio_helper.dart';
import '../../shared/constants.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  List<Slides> slides = [];
  List<Places> mostBooked = [];

  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  void getHome() async {
    emit(GetHomeLoadingState());
    try {
      var response = await DioHelper.getData(url: "home", header: {
        "lang": lang,
      });
      homeModel = HomeModel.fromJson(response.data);
      emit(GetHomeSuccessState());
    } catch (e) {
      print(e.toString());
      homeModel = HomeModel.fromJson({});
      emit(GetHomeErrorState());
    }
  }

  void getSliders() async {
    emit(GetSlidersLoading());
    try {
      var response = await DioHelper.getData(url: "sliders", header: {
        "lang": lang,
      });
      final slidersModel = SlidersModel.fromJson(response.data);
      slides = slidersModel.slides;
      emit(GetSlidersSuccess());
    } catch (e) {
      print(e.toString());
      // homeModel = HomeModel.fromJson({});
      emit(GetSlidersFailed(error: e.toString()));
    }
  }

  void getMostBooked() async {
    emit(GetMostBookedLoading());
    try {
      var response = await DioHelper.getData(url: "most-booked", header: {
        "lang": lang,
        "Authorization": "Bearer ${CacheHelper.getData("userToken")}",
      });
      log('response: ${response.data}');
      final json = response.data as Map<String, dynamic>;
      mostBooked =
          List.from(json['data']).map((e) => Places.fromJson(e)).toList();
      emit(GetMostBookedSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetMostBookedFailed(error: e.toString()));
    }
  }

  NotificationsModel? notificationsModel;
  void getUserNotifications() async {
    emit(GetUserNotificationsLoadingState());
    try {
      var response = await DioHelper.getData(url: "my-notifactions", header: {
        "lang": lang,
      });
      notificationsModel = NotificationsModel.fromJson(response.data);
      emit(GetUserNotificationsSuccessState());
    } catch (e) {
      print(e.toString());
      notificationsModel = NotificationsModel.fromJson({});
      emit(GetUserNotificationsErrorState());
    }
  }
//
//
//   void getAllActivities() async{
//     emit(GetActivitiesLoadingState());
//     var position = await determinePosition();
//     try{
//       var response = await DioHelper.getData(url: "api/v1/users/activities",header: {
//         "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
//       });
//       print(response.data);
//       activitiesModel = ActivitiesModel.fromJson(response.data);
//       activitiesModel.data!.forEach((element) {
// if(element.latitude != null && element.longitude != null){
//   if((Geolocator.distanceBetween(position.latitude, position.longitude, double.parse(activitiesModel.data![0].latitude.toString()),double.parse(activitiesModel.data![0].longitude.toString())))/1000 > 20){
//     nearbyActivities.add(element);
//   }
// }        print(nearbyActivities.length);
//       });
//
//       emit(GetActivitiesSuccessState());
//
//     }catch(e){
//       print(e.toString());
//       activitiesModel = ActivitiesModel.fromJson({});
//       emit(GetActivitiesErrorState());
//     }
//   }
//
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
//
//   Future<String> scanQr() async {
//    return await FlutterBarcodeScanner.scanBarcode(
//         '#FF0076', 'close', true, ScanMode.QR);
//
//   }
//
//
//
//
//
// }
}
