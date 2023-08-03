import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/filter_cubit/filter_cubit.dart';
import 'package:mazraaty/shared/components.dart';

import '../cubits/filter_cubit/filter_states.dart';
import '../shared/custom_text_field.dart';

class FilterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title:"filter".tr()),
      body: BlocBuilder<FilterCubit,FilterStates>(
        builder: (context, state) {
          if(FilterCubit.get(context).places != null){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    label: "enterYourSearchWords".tr(),
                    textInputType: TextInputType.text,
                    onChanged: (String? value){
                      FilterCubit.get(context).searchPlaces(value);
                    },
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return buildProductItem(context,FilterCubit.get(context).places!.data!.data![index]);
                    }, itemCount: FilterCubit.get(context).places!.data!.data!.length),
                  )
                ],
              ),
            );
          }else{
            return customCircleProgressIndicator();
          }
        },
      )
    );
  }
}
