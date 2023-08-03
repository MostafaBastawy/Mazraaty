import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/models/places_categories_model.dart';

import '../../models/regions_model.dart';
import '../../networks/local/cache_helper.dart';
import '../../networks/remote/dio_helper.dart';
import '../../shared/constants.dart';
import 'filter_states.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(FilterInitialState());
  static FilterCubit get(context) => BlocProvider.of(context);
  Places? places;
  void getPlacesByCategory(int? categoryId) async{
    emit(GetPlacesByCategoryLoadingState());
     var response = await DioHelper.getData(url: "catgory-places",query: {
       "cat_id" : categoryId,
     },header: {
       "lang" : lang,
     });
     print(response.data);
     places = Places.fromJson(response.data);
     emit(GetPlacesByCategorySuccessState());

  }

  Future<dynamic> filterPlaces(int? catId , String? availableDate , int orderByPrice ,int? regionId ) async{
    emit(PlacesFilterLoadingState());
    var response = await DioHelper.getData(url: "filter",query: {
      "cat_id" : catId,
      "avilable_date" : availableDate,
      "orderByPrice" : orderByPrice,
      "governorate_id" : regionId
    },header: {
      "lang" : lang,
    });
    print(response.data);
    places = Places.fromJson(response.data);
    emit(PlacesFilterSuccessState());
    return response.data;
  }

  Future<dynamic> searchPlaces(String? keyWord) async{
    emit(PlacesSearchLoadingState());
    var response = await DioHelper.getData(url: "search",query: {
      "keyword" : keyWord,
    },header: {
      "lang" : lang,
    });
    print(response.data);
    places = Places.fromJson(response.data);
    emit(PlacesSearchSuccessState());
    return response.data;
  }

  late RegionsModel regionsModel;

  void getAllRegions() async{
    emit(GetRegionsLoadingState());
      var response = await DioHelper.getData(url: "governorates",header: {
        "lang" : lang,
      });
      print(response.data);
      regionsModel = RegionsModel.fromJson(response.data);
      emit(GetRegionsSuccessState());
  }
}
