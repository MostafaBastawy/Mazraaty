import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/favorite_model.dart';
import '../../networks/remote/dio_helper.dart';
import 'favourite_states.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(FavouriteInitialState());
  static FavouriteCubit get(context) => BlocProvider.of(context);

  FavouriteModel? favouriteModel;
  void getAllFavourites() async {
    emit(GetFavouriteLoadingState());
    try {
      var response = await DioHelper.getData(url: "my-fav", header: {
        // "Authorization": "Bearer ${CacheHelper.getData("userToken")}",
      });
      favouriteModel = FavouriteModel.fromJson(response.data);
      print(response.data);
      emit(GetFavouriteSuccessState());
    } catch (e) {
      print(e.toString());
      favouriteModel = FavouriteModel.fromJson({});
      emit(GetFavouriteErrorState());
    }
  }

  Future<dynamic> makeFavourite(int? id) async {
    emit(MakeFavouriteLoadingState());
    var response =
        await DioHelper.getData(url: "fav-add-remove", query: {"place_id": id});
    getAllFavourites();
    emit(MakeFavouriteSuccessState());
    return response.data;
  }
}
