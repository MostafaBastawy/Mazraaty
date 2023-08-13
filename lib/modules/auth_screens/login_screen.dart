import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/modules/auth_screens/register_screen.dart';
import 'package:mazraaty/networks/local/cache_helper.dart';

import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_states.dart';
import '../../layout/home_layout.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context: context, title: "login".tr()),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                )),
            Text(
              "phoneNumber".tr(),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            CustomTextField(
              label: "",
              textInputType: TextInputType.phone,
              controller: phoneController,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "password".tr(),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            CustomTextField(
              label: "",
              textInputType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
              if (state is! UserLoginLoadingState) {
                return CustomButton(
                  onPressed: () async {
                    var result = await AuthCubit.get(context).userLogin(
                        phoneController.text, passwordController.text);
                    final String? userToken =
                        await CacheHelper.getData("userToken");

                    if (userToken != null) {
                      navigateAndFinish(context, HomeLayout());
                    } else {
                      showToast(result.data["msg"]);
                    }
                  },
                  text: "login".tr(),
                  textColor: Colors.white,
                );
              } else {
                return customCircleProgressIndicator();
              }
            }),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              color: kAppSecondColor,
              onPressed: () async {
                navigateTo(context: context, page: RegisterScreen());
              },
              text: "createNewAccount".tr(),
              textColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  navigateTo(context: context, page: HomeLayout());
                },
                child: Text("skipLogin".tr())),
          ],
        ));
  }
}
