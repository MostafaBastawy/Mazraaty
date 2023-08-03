abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetHomeLoadingState extends HomeStates {}

class GetHomeSuccessState extends HomeStates {}

class GetHomeErrorState extends HomeStates {}

class GetSlidersLoading extends HomeStates {}

class GetSlidersSuccess extends HomeStates {}

class GetSlidersFailed extends HomeStates {
  final String error;
  GetSlidersFailed({required this.error});
}

class GetMostBookedLoading extends HomeStates {}

class GetMostBookedSuccess extends HomeStates {}

class GetMostBookedFailed extends HomeStates {
  final String error;
  GetMostBookedFailed({required this.error});
}

class GetUserNotificationsLoadingState extends HomeStates {}

class GetUserNotificationsSuccessState extends HomeStates {}

class GetUserNotificationsErrorState extends HomeStates {}
