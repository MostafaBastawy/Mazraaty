import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/models/places_categories_model.dart';

import '../../models/place_model.dart';
import '../../networks/remote/dio_helper.dart';
import '../../shared/constants.dart';
import 'places_states.dart';

class PlacesCubit extends Cubit<PlacesStates> {
  PlacesCubit() : super(PlacesInitialState());
  static PlacesCubit get(context) => BlocProvider.of(context);
  late Places places;
  PlaceModel? placeModel;



  void getSinglePlace(int? id) async {
    emit(GetSingleCategoryLoadingState());
    var response = await DioHelper.getData(url: "/single-place", query: {
      "place_id": id
    },header: {
      "lang" : lang,
    });
    placeModel = PlaceModel.fromJson(response.data);
    emit(GetSingleCategorySuccessState());
  }






}

