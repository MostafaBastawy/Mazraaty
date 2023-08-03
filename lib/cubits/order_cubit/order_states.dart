import '../../models/rate_model.dart';

abstract class OrderStates {}

class FavouriteInitialState extends OrderStates {}

class OrderRefreshState extends OrderStates {}

class MakeOrderLoadingState extends OrderStates {}

class MakeOrderSuccessState extends OrderStates {}

class CheckDateLoadingState extends OrderStates {}

class CheckDateSuccessState extends OrderStates {}

class GetPaymentDataLoadingState extends OrderStates {}

class GetPaymentDataSuccessState extends OrderStates {}

class RatePlaceLoadingState extends OrderStates {}

class RatePlaceSuccessState extends OrderStates {
  final RateModel? rateModel;
  RatePlaceSuccessState({required this.rateModel});
}

class RatePlaceFailed extends OrderStates {}
