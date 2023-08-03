import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../cubits/settings_cubit/settings_cubit.dart';
import '../cubits/settings_cubit/settings_states.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class LanguageScreen extends StatelessWidget {
  List<Map<String, String>> languages = [
    {"image": "assets/images/lang 1.png", "title": "العربية", "lang": "ar"},
    {"image": "assets/images/lang 2.png", "title": "English", "lang": "en"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "selectLanguage".tr()),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("pleaseChooseFromHereLanguageOfTheApp".tr()),
                ),
                ...List.generate(
                    languages.length,
                    (index) => buildItem(languages[index]["image"]!,
                        languages[index]["title"]!, index)),
                // SizedBox(height: 20,),
                // BlocBuilder<SettingsCubit,SettingsStates>(builder: (context, state) {
                //   if(state is ! UpdateLanguageLoadingState){
                //     return CustomButton(
                //       onPressed: (){
                //
                //       },
                //       color: kAppSecondColor,
                //       text: "continue".tr(),
                //     );
                //   }else{
                //     return customCircleProgressIndicator();
                //   }
                // })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String image, String title, index) =>
      BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) => InkWell(
          onTap: () {
            SettingsCubit.get(context)
                .changeLanguageState(languages[index]["lang"], index, context);
            Phoenix.rebirth(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: languages[index]["lang"] == lang
                    ? kAppColor
                    : Colors.white),
            child: Center(
              child: ListTile(
                leading: Image.asset(image),
                title: Text(
                  title,
                  style: TextStyle(
                      color: languages[index]["lang"] == lang
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        ),
      );
}
