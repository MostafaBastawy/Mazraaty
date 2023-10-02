import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_states.dart';
import '../../layout/home_layout.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context: context, title: "createNewAccount".tr()),
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
              "fullName".tr(),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            CustomTextField(
              label: "",
              textInputType: TextInputType.name,
              controller: nameController,
            ),
            SizedBox(
              height: 15,
            ),
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
              height: 40,
            ),
            BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
              if (state is! UserRegisterLoadingState) {
                return CustomButton(
                  color: kAppSecondColor,
                  onPressed: () async {
                    var result = await AuthCubit.get(context).userRegister(
                        phoneController.text,
                        passwordController.text,
                        nameController.text);
                    if (result["status"]) {
                      navigateAndFinish(context, HomeLayout());
                    } else {
                      showToast(result["msg"]);
                    }
                  },
                  text: "registerNow".tr(),
                  textColor: Colors.white,
                );
              } else {
                return customCircleProgressIndicator();
              }
            }),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 60),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text(
            //         "لديك حساب بالفعل؟",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20,
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {
            //           navigateAndFinish(context, LoginScreen());
            //         },
            //         child: Text(
            //           "سجل دخول",
            //           style: TextStyle(
            //             color: kAppColor,
            //             fontSize: 18,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
