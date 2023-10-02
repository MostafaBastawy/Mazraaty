import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../networks/local/cache_helper.dart';
import '../../networks/remote/dio_helper.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  // Future<dynamic> checkUserExist(String mobile) async {
  //   emit(CheckUserExistLoadingState());
  //   FormData formData = FormData.fromMap({
  //     "mobile" : mobile
  //   });
  //    var result = await DioHelper.postData(url: "api/v1/users/auth/checkClientExists",data: formData,header: {});
  //    print(result);
  //   emit(CheckUserExistSuccessState());
  //    return result.data;
  // }

  Future<void> userLogin(String phone, String password) async {
    emit(UserLoginLoadingState());
    FormData formData =
        FormData.fromMap({"phone": phone, "password": password});
    final Response result =
        await DioHelper.postData(url: "login", data: formData);
    print(result.data);
    if (result.data["status"]) {
      await CacheHelper.setData("userToken", result.data["data"]["api_token"]);
      await CacheHelper.setData("userName", result.data["data"]["name"]);
      await CacheHelper.setData("userPhone", result.data["data"]["phone"]);
      emit(UserLoginSuccessState());
      await sendDeviceToken();
    } else {
      emit(UserLoginErrorState(message: result.data["msg"]));
    }
  }

  Future<String?> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    return await messaging.getToken();
  }

  Future<dynamic> userRegister(
      String phone, String password, String name) async {
    emit(UserRegisterLoadingState());
    FormData formData = FormData.fromMap({
      "phone": phone,
      "password": password,
      "name": name,
    });
    var result = await DioHelper.postData(url: "signup", data: formData);
    print(result.data);
    if (result.data["status"]) {
      await CacheHelper.setData("userToken", result.data["data"]["api_token"]);
      await CacheHelper.setData("userName", result.data["data"]["name"]);
      await CacheHelper.setData("userPhone", result.data["data"]["phone"]);
      await sendDeviceToken();
    }
    emit(UserRegisterSuccessState());
    return result.data;
  }

  Future<dynamic> sendDeviceToken() async {
    emit(SendDeviceTokenLoadingState());
    String? token = await getDeviceToken();
    print(token);
    FormData formData = FormData.fromMap({
      "fcm_token": token,
    });
    var result =
        await DioHelper.postData(url: "fcm-token", data: formData, header: {
      "Authorization": "Bearer ${CacheHelper.getData("userToken")}",
    });
    emit(SendDeviceTokenSuccessState());
    return result.data;
  }

  // Future<dynamic> userSocialLogin(String name, String providerId, String provider) async {
  //   emit(UserSocialLoginLoadingState());
  //   String? token = await getDeviceToken();
  //   FormData formData = FormData.fromMap({
  //     "provider_id" : providerId,
  //     "provider" : provider,
  //     "device_token" : token,
  //     "name" : name,
  //   });
  //
  //   var result = await DioHelper.postData(url: "api/v1/users/auth/social_login",data: formData);
  //   print(result.data);
  //   if(result.data["success"]){
  //     await CacheHelper.setData("userToken", result.data["data"]["access_token"]);
  //   }
  //   emit(UserSocialLoginSuccessState());
  //   return result.data;
  // }

  // Future<dynamic> changePassword(String oldPassword,String newPassword,String confirmPassword) async {
  //   emit(ChangePasswordLoadingState());
  //   FormData formData = FormData.fromMap({
  //     "current_password" : oldPassword,
  //     "password" : newPassword,
  //     "confirm_password" : confirmPassword,
  //   });
  //
  //   var result = await DioHelper.postData(url: "api/v1/users/account/updatePassword",data: formData);
  //
  //   emit(ChangePasswordSuccessState());
  //   return result.data;
  // }

  // Future<dynamic> resetPassword(String phoneNumber,String newPassword,String confirmPassword,String code) async {
  //   emit(ResetPasswordLoadingState());
  //   FormData formData = FormData.fromMap({
  //     "mobile" : phoneNumber,
  //     "password" : newPassword,
  //     "password_confirmation" : confirmPassword,
  //     "code" : code,
  //   });
  //
  //   var result = await DioHelper.postData(url: "api/v1/users/auth/reset",data: formData);
  //
  //   emit(ResetPasswordSuccessState());
  //   return result.data;
  // }

  // Future<dynamic> signInWithGoogle() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleSignInAccount =
  //     await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     var user = await _auth.signInWithCredential(credential);
  //     return await userSocialLogin(user.user!.displayName.toString(),user.user!.uid.toString(),"google");
  // }
  //
  // Future<dynamic> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   print("=============face==================");
  //   print("message${result.message}");
  //   print("accessToken${result.accessToken}");
  //   switch (result.status) {
  //     case LoginStatus.success:
  //       print(result.accessToken!.token);
  //       final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
  //       var userCredential = await  FirebaseAuth.instance.signInWithCredential(facebookCredential);
  //       print("success");
  //       return await userSocialLogin(userCredential.user!.displayName.toString(),userCredential.user!.uid.toString(),"facebook");
  //     case LoginStatus.cancelled:
  //       print("cancelled");
  //       return Resource(status: Status.Cancelled);
  //     case LoginStatus.failed:
  //       print("failed");
  //       return Resource(status: Status.Error);
  //     default:
  //       return null;
  //   }
  // }

  // late RegionsModel regionsModel;
  //
  // void getAllRegions() async{
  //   emit(GetRegionsLoadingState());
  //   try{
  //     var response = await DioHelper.getData(url: "getRegions/${countryCode == "EG" ? "ku" : lang}");
  //     print(response.data);
  //     regionsModel = RegionsModel.fromJson(response.data);
  //     emit(GetRegionsSuccessState());
  //   }catch(e){
  //     print(e.toString());
  //     regionsModel = RegionsModel.fromJson({});
  //     emit(GetRegionsErrorState());
  //   }
  // }

  Future<dynamic> logout() async {
    var response = await DioHelper.getData(url: "logout", header: {
      "Authorization": "Bearer ${CacheHelper.getData("userToken")}",
    });
    CacheHelper.removeData("userToken");
    print(response.data);
    return response.data;
  }

  Future<dynamic> deleteAccount() async {
    var response = await DioHelper.getData(url: "delete-account", header: {
      "Authorization": "Bearer ${CacheHelper.getData("userToken")}",
    });
    CacheHelper.removeData("userToken");
    print(response.data);
    return response.data;
  }
}
