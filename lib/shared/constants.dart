import 'package:flutter/material.dart';

import '../networks/local/cache_helper.dart';

const Color kAppColor = Color(0xff18AAE0);
const Color kAppSecondColor = Color(0xff0A0E13);
const authBackgroundColor = Color(0xffF2F2F2);
const Color lightBgGrey = Color(0xfff4f8ff);
const highlightColor = Color(0xFFFDF9F9);

const String baseUrl = "https://stayat.website/api/";

String lang = CacheHelper.getData("userLang") ?? "ar";
