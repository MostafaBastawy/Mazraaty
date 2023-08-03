import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../cubits/profile_cubit/profile_states.dart';
import '../shared/components.dart';
import '../shared/constants.dart';

class MyPlacesScreen extends StatefulWidget {
  const MyPlacesScreen({Key? key}) : super(key: key);

  @override
  State<MyPlacesScreen> createState() => _MyPlacesScreenState();
}

class _MyPlacesScreenState extends State<MyPlacesScreen> {

  @override
  void initState() {
    // TODO: implement initState
    ProfileCubit.get(context).getMyPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text("myPlaces".tr()),
                  ),
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
            BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
              if(state is ! GetMyPlacesLoadingState){
                
                return Expanded(
                  child: ProfileCubit.get(context).myPlacesModel!.data!.isNotEmpty ? ListView.separated(
                    padding: EdgeInsets.all(20),

                      itemBuilder: (context, index){
                      return InkWell(
                        // onTap: (){
                        //   navigateTo(context: context, page: PlaceDetailsScreen(
                        //     placeId: model.id,
                        //     placeName: model.name,
                        //   ));
                        // },
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(ProfileCubit.get(context).myPlacesModel!.data![index].image!),
                          ),),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("${ProfileCubit.get(context).myPlacesModel!.data![index].name} ${ProfileCubit.get(context).myPlacesModel!.data![index].price} ${"dinar".tr()}",style: TextStyle(color: Colors.white),),
                              )),
                        ),
                      );
                        return buildProductItem(context,ProfileCubit.get(context).myPlacesModel!.data![index]);
                      }, separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: ProfileCubit.get(context).myPlacesModel!.data!.length):Text("noPlacesYet".tr()),
                );
              }else{
                return Expanded(child: customCircleProgressIndicator());
              }

            },)
          ],
        ),
      ),
    );
  }
}
