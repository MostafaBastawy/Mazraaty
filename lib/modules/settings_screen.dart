import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/profile_cubit/profile_states.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../networks/local/cache_helper.dart';
import '../shared/components.dart';
import '../shared/constants.dart';
import 'auth_screens/login_screen.dart';
import 'language_screen.dart';
import 'my_places_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    ProfileCubit.get(context).getMyPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final token = CacheHelper.getData("userToken");
    return Scaffold(
      body: Column(
        children: [
          token != null
              ? Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: kAppColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(CacheHelper.getData("userName"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text(CacheHelper.getData("userPhone"),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 30,
                ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ProfileCubit.get(context).myPlacesModel != null)
                    if (ProfileCubit.get(context)
                        .myPlacesModel!
                        .data!
                        .isNotEmpty)
                      BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                          return buildItem(
                              title: "myPlaces".tr(),
                              onTap: () {
                                navigateTo(
                                    context: context, page: MyPlacesScreen());
                              },
                              image: "assets/images/settings 1.png");
                        },
                      ),
                  buildItem(
                      title: "aboutUs".tr(),
                      onTap: () {
                        // navigateTo(context: context, page: WebViewScreen(url: "https://alawrad.online/index.php/about/",));
                      },
                      image: "assets/images/settings 1.png"),
                  //
                  // buildItem(title: "privacyPolicy".tr(),onTap: (){
                  //   navigateTo(context: context, page: WebViewScreen(url: "https://alawrad.online/index.php/privacy-policy/",));
                  // },image: "assets/images/settings 1.png"),
                  buildItem(
                      title: "shareApp".tr(),
                      onTap: () {},
                      image: "assets/images/settings 2.png"),
                  buildItem(
                      title: "rateOnStore".tr(),
                      onTap: () {},
                      image: "assets/images/settings 3.png"),
                  buildItem(
                      title: "changeLanguage".tr(),
                      onTap: () {
                        navigateTo(context: context, page: LanguageScreen());
                      },
                      image: "assets/images/settings 4.png"),

                  buildItem(
                      title:
                          // CacheHelper.getData("userToken")!= null ?
                          token != null ? "logOut".tr() : "login".tr(),
                      onTap: () async {
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return LoginScreen();
                            },
                          ),
                          (_) => false,
                        );
                        if (token != null) {
                          var result = await AuthCubit.get(context).logout();
                          if (result["status"]) {
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                              (_) => false,
                            );
                          } else {
                            showToast(result["msg"]);
                          }
                        }
                      },
                      image: "assets/images/settings 5.png"),
                  if (token != null)
                    buildItem(
                        title: "deleteAccount".tr(),
                        isDeleteAccount: true,
                        onTap: () async {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: "deleteAccount".tr(),
                            desc: "areYouSureWantToDeleteYourAccount".tr(),
                            btnOkText: "confirm".tr(),
                            btnCancelText: "cancel".tr(),
                            btnCancelOnPress: () => Navigator.pop(context),
                            btnOkColor: kAppColor,
                            btnOkOnPress: () async {
                              Navigator.pop(context);
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return LoginScreen();
                                  },
                                ),
                                (_) => false,
                              );
                              if (token != null) {
                                var result = await AuthCubit.get(context)
                                    .deleteAccount();
                                if (result["status"]) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return LoginScreen();
                                      },
                                    ),
                                    (_) => false,
                                  );
                                } else {
                                  showToast(result["msg"]);
                                }
                              }
                            },
                          )..show();
                        },
                        image: "assets/images/settings 6.png"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    Function()? onTap,
    String? title,
    String? image,
    bool isDeleteAccount = false,
  }) =>
      Column(
        children: [
          ListTile(
            onTap: onTap,
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Image.asset(
              image!,
              color: isDeleteAccount ? Colors.red : kAppColor,
              height: 24,
              width: 24,
            ),
            title: Text(
              title!,
              style: TextStyle(
                  color: isDeleteAccount ? Colors.red : Colors.black,
                  fontSize: 16),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          )
        ],
      );
}
