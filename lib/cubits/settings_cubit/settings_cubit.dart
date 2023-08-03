import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/settings_cubit/settings_states.dart';

import '../../networks/local/cache_helper.dart';
import '../../shared/constants.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  int? currentIndex;

  changeLanguageState(val, index, context) async {
    lang = val;
    currentIndex = index;
    CacheHelper.setData("userLang", val);
    await EasyLocalization.of(context)!.setLocale(Locale(lang));
    emit(ChangeLanguageSuccessState());
  }
}
