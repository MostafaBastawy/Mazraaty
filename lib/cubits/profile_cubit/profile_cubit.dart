
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazraaty/cubits/profile_cubit/profile_states.dart';
import '../../models/categories_model.dart';
import '../../models/governorates_model.dart';
import '../../models/places_attributes_v1_model.dart';
import '../../models/places_attributes_v2_model.dart';
import '../../models/places_model.dart';
import '../../networks/local/cache_helper.dart';
import '../../networks/remote/dio_helper.dart';
import '../../shared/constants.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  GovernoratesModel? governoratesModel;
  void getGovernorates() async {
    emit(GetGovernoratesLoadingState());
    try {
      var response = await DioHelper.getData(url: "governorates",header: {
        "lang" : lang,
        "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
      });
      governoratesModel = GovernoratesModel.fromJson(response.data);
      emit(GetGovernoratesSuccessState());
    } catch (e) {
      print(e.toString());
      governoratesModel = GovernoratesModel.fromJson({});
      emit(GetGovernoratesErrorState());
    }
  }
  // Future<Response?> getNotifications()async{
  //   try{
  //     emit(GetCouponsLoadingState());
  //     var response = await DioHelper.getData(url: "my-notification",header: {
  //       "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
  //       "lang" : lang,
  //     });
  //     print(response.data);
  //     coupons = CouponsModel.fromJson(response.data);
  //     emit(GetCouponsSuccessState());
  //     return response;
  //   }catch(e){
  //     print(e.toString());
  //     emit(GetCouponsErrorState());
  //     return null;
  //   }
  // }




  MyPlacesModel? myPlacesModel;

  void getMyPlaces() async {
    emit(GetMyPlacesLoadingState());
    var response = await DioHelper.getData(url: "myplaces",header: {
      "lang" : lang,
      "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
    });
    myPlacesModel = MyPlacesModel.fromJson(response.data);
    emit(GetMyPlacesSuccessState());
  }


  int visitorNumber = 10;
  void increaseCounter(){
    visitorNumber++;
    emit(AddPlaceRefreshState());
  }
  void decrementCounter(){
    if(visitorNumber != 1){
      visitorNumber--;
      emit(AddPlaceRefreshState());
    }
  }

  List<PickedFile> placeImages = [];
  List<AttributeV1> amenitiesV1 = [];
  List<AttributeV2> amenitiesV2 = [];
  List<int> amenitiesV1Ids = [];
  List<Map<String,dynamic>> amenitiesV2Objects = [];


  void selectPlaceImages()async{
    placeImages = (await ImagePicker.platform.pickMultiImage())!;
    emit(AddPlaceRefreshState());
  }
  CategoriesModel? categoriesModel;
  PlacesAttributesV1Model? placesAttributesV1Model;
  PlacesAttributesV2Model? placesAttributesV2Model;
  void getCategories() async {
    emit(GetCategoriesLoadingState());
    var response = await DioHelper.getData(url: "catgories", query: {
    },header: {
      "lang" : lang,
      "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
    });
    categoriesModel = CategoriesModel.fromJson(response.data);
    emit(GetCategoriesSuccessState());
  }

  void getAttributesV1() async {
    emit(GetAttributesV1LoadingState());
    var response = await DioHelper.getData(url: "place-attributes-v1", query: {
    },header: {
      "lang" : lang,
      "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
    });
    placesAttributesV1Model = PlacesAttributesV1Model.fromJson(response.data);
    emit(GetAttributesV1SuccessState());
  }

  void getAttributesV2() async {
    emit(GetAttributesV2LoadingState());
    var response = await DioHelper.getData(url: "place-attributes-v2", query: {
    },header: {
      "lang" : lang,
      "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
    });
    placesAttributesV2Model = PlacesAttributesV2Model.fromJson(response.data);
    emit(GetAttributesV2SuccessState());
  }

  Future<Response> addPlace({
  String? nameAr,
  String? nameEn,
  String? aboutAr,
  String? aboutEn,
  String? price,
  int? categoryId,
  int? cityId,


})async{
    FormData formData = FormData.fromMap({
      "name_ar" : nameAr,
      "name_en" : nameEn,
      "price" : price,
      "about_ar" : aboutAr,
      "about_en" : aboutEn,
      "category_id" : categoryId,
      "city_id" : cityId,
      // "capacity" : visitorNumber,
      "attrv1[]" : amenitiesV1Ids,
      // "attrv2" :
    });
    for (var item in placeImages) {
      formData.files.addAll([
        MapEntry("images[]", await MultipartFile.fromFile(item.path)),
      ]);
    }
    emit(AddPlaceLoadingState());
    var response = await DioHelper.postData(url: "add-place",data: formData,header: {
      "lang" : lang,
      "Authorization" : "Bearer ${CacheHelper.getData("userToken")}",
    });
    print(response.data);
    emit(AddPlaceSuccessState());
    return response;

  }




}