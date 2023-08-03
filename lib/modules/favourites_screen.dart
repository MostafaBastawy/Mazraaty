

import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/Favourite_cubit/favourite_cubit.dart';

import '../cubits/Favourite_cubit/favourite_states.dart';
import '../shared/components.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    FavouriteCubit.get(context).getAllFavourites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppbar(context: context, title: "favourite".tr(),navigate: false),
      body:  BlocBuilder<FavouriteCubit,FavouriteStates>(
        builder: (context, state) {
          FavouriteCubit cubit = FavouriteCubit.get(context);
          if(cubit.favouriteModel != null){
            return ListView.builder(
              padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
              return buildProductItem(context,cubit.favouriteModel!.data![index]);
            }, itemCount: cubit.favouriteModel!.data!.length);
          }else{
            return customCircleProgressIndicator();
          }
        },
      )
    );
  }
}
