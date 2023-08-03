import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mazraaty/cubits/places_cubit/places_cubit.dart';
import 'package:mazraaty/cubits/places_cubit/places_states.dart';
import 'package:mazraaty/models/home_model.dart';
import 'package:mazraaty/modules/reservation_screen.dart';
import 'package:mazraaty/shared/components.dart';
import 'package:mazraaty/shared/constants.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/auth_cubit/auth_states.dart';
import '../shared/custom_button.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final int? placeId;
  final String? placeName;
  const PlaceDetailsScreen({Key? key, this.placeId, this.placeName}) : super(key: key);

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    PlacesCubit.get(context).getSinglePlace(widget.placeId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title:widget.placeName!),
      body: BlocBuilder<PlacesCubit,PlacesStates>(
        builder: (context, state) {
          if(PlacesCubit.get(context).placeModel != null){
            return  Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  // ...List.generate(PlacesCubit.get(context).placeModel!.data!.images!.length, (index){
                  //   return Column(
                  //     children: [
                  //       Container(
                  //         height: 150,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image: DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: NetworkImage(PlacesCubit.get(context).placeModel!.data!.images![index].image!),
                  //         ),),
                  //       ),
                  //       SizedBox(height: 10,),
                  //       GridView.count(
                  //         crossAxisCount: 3,
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         crossAxisSpacing: 10,
                  //         mainAxisSpacing: 10,
                  //         children: List.generate(PlacesCubit.get(context).placeModel!.data!.images!.length, (i){
                  //           return Container(
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(15),image: DecorationImage(
                  //                   fit: BoxFit.cover,
                  //                   image:  NetworkImage(PlacesCubit.get(context).placeModel!.data!.images![i].image!)
                  //               )));
                  //         }),
                  //       ),
                  //     ],
                  //   );
                  // }),
              GridView.custom(
                shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  QuiltedGridTile(1, 3),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                  QuiltedGridTile(1, 1),
                ],
              ),

              childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(PlacesCubit.get(context).placeModel!.data!.images![index].image!),
                              ),),
                            ),
                childCount: PlacesCubit.get(context).placeModel!.data!.images!.length
              ),

            ),
                  Row(
                    children: [
                      Text(PlacesCubit.get(context).placeModel!.data!.name! , style: TextStyle(color: Colors.black,fontSize: 20),),
                      SizedBox(width: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("${PlacesCubit.get(context).placeModel!.data!.price} ", style: TextStyle(color: Colors.black,fontSize: 25),),
                          Text("forDay".tr(), style: TextStyle(color: Colors.black),),

                        ],
                      )],
                  ),
                  Text(PlacesCubit.get(context).placeModel!.data!.about!),
                  Text("farmFeatures".tr() , style: TextStyle(color: kAppColor),),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    children: List.generate(PlacesCubit.get(context).placeModel!.data!.properties!.length, (index){
                      return Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: kAppColor,borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(width: 5,),
                          Expanded(child: Text(PlacesCubit.get(context).placeModel!.data!.properties![index].name!,)),

                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 20,),
              CustomButton(
                color: kAppSecondColor,
                onPressed: () async {
                  navigateTo(context: context, page: ReservationScreen());
                },
                text: "reserveNow".tr(),
                textColor: Colors.white,

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
