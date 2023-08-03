abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class CheckUserExistLoadingState extends AuthStates {}

class CheckUserExistSuccessState extends AuthStates {}

class UserLoginLoadingState extends AuthStates {}

class UserLoginSuccessState extends AuthStates {}

class UserRegisterLoadingState extends AuthStates {}

class UserRegisterSuccessState extends AuthStates {}

class GetRegionsLoadingState extends AuthStates {}

class GetRegionsSuccessState extends AuthStates {}

class GetRegionsErrorState extends AuthStates {}

class AppRefreshState extends AuthStates {}

class UserSocialLoginLoadingState extends AuthStates {}

class UserSocialLoginSuccessState extends AuthStates {}

class ChangePasswordLoadingState extends AuthStates {}

class ChangePasswordSuccessState extends AuthStates {}

class SendDeviceTokenLoadingState extends AuthStates {}

class SendDeviceTokenSuccessState extends AuthStates {}

class ForgetPasswordLoadingState extends AuthStates {}

class ForgetPasswordSuccessState extends AuthStates {}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ChangeGenderSuccessState extends AuthStates {}

class ChangeBirthDateSuccessState extends AuthStates {}

