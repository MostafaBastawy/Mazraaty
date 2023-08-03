import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextSearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? searchController;
  const CustomTextSearchField({Key? key, this.onChanged, this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
      controller: searchController,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: "searchForAnyProduct".tr(),
        hintStyle: Theme.of(context).textTheme.caption,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide(color: Colors.white)),
        isDense: true,
        suffixIcon: Icon(CupertinoIcons.search,color: Colors.grey,)
      ),
    );
  }
}
