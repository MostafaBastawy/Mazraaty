import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/favorite_model.dart';
import '../../models/payment_model.dart';
import '../../models/rate_model.dart';
import '../../networks/remote/dio_helper.dart';
import '../../shared/constants.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(FavouriteInitialState());
  static OrderCubit get(context) => BlocProvider.of(context);

  FavouriteModel? favouriteModel;
  // void getAllFavourites() async{
  //   emit(GetFavouriteLoadingState());
  //   try{
  //     var response = await DioHelper.getData(url: "my-fav");
  //     favouriteModel = FavouriteModel.fromJson(response.data);
  //     print(response.data);
  //     emit(GetFavouriteSuccessState());
  //   }catch(e){
  //     print(e.toString());
  //     favouriteModel = FavouriteModel.fromJson({});
  //     emit(GetFavouriteErrorState()
  //     );
  //   }
  // }

  Future<dynamic> checkDate(int? id, String? date) async {
    emit(CheckDateLoadingState());
    var response = await DioHelper.getData(url: "check-date", query: {
      "place_id": id,
      "date": date,
    }, header: {
      "lang": lang,
    });
    print(response.data);
    emit(CheckDateSuccessState());
    return response.data;
  }

  PaymentModel? paymentModel;
  Future<dynamic> getPaymentData() async {
    emit(GetPaymentDataLoadingState());
    var response = await DioHelper.getData(url: "setting", header: {
      "lang": lang,
    });
    paymentModel = PaymentModel.fromJson(response.data);
    print('Mostafaaa: ${response.data}');
    emit(GetPaymentDataSuccessState());
    return response.data;
  }

  Future<dynamic> makeOrder(int? id) async {
    FormData formData = FormData.fromMap({
      "place_id": id,
      "date": focusedDay,
      "days": day,
      "total": total,
    });
    emit(MakeOrderLoadingState());
    var response =
        await DioHelper.postData(url: "book-place", data: formData, header: {
      "lang": lang,
    });
    print(response.data);
    emit(MakeOrderSuccessState());
    return response.data;
  }

  bool isRated = false;
  RateModel? rateModel;
  Future<dynamic> ratePlace(
      {required int id, required String rate, String? comment}) async {
    FormData formData = FormData.fromMap({
      "place_id": id,
      "rate": rate,
      "comment": comment,
    });
    emit(RatePlaceLoadingState());
    var response =
        await DioHelper.postData(url: "addRate", data: formData, header: {
      "lang": lang,
    });
    rateModel = RateModel.fromJson(response.data);
    print(response.data);
    isRated = true;
    emit(RatePlaceSuccessState(rateModel: rateModel));
    return response.data;
  }

  int day = 1;
  int total = 0;
  DateTime focusedDay = DateTime.now();
  void increaseCounter() {
    day++;
    emit(OrderRefreshState());
  }

  void decrementCounter() {
    if (day != 1) {
      day--;
      emit(OrderRefreshState());
    }
  }
}
