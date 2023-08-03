import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/home_cubit/home_cubit.dart';

import '../cubits/home_cubit/home_states.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../cubits/profile_cubit/profile_states.dart';
import '../shared/components.dart';
import '../shared/constants.dart';
import '../shared/custom_button.dart';
import '../shared/custom_text_field.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    ProfileCubit.get(context).getCategories();
    // PlacesCubit.get(context).getBookType();
    ProfileCubit.get(context).getAttributesV1();
    ProfileCubit.get(context).getAttributesV2();
    ProfileCubit.get(context).getGovernorates();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ProfileCubit.get(context).placeImages.clear();
    ProfileCubit.get(context).amenitiesV1.clear();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  int _index = 0;

  TextEditingController farmNameInArabic = TextEditingController();
  TextEditingController farmNameInEnglish = TextEditingController();
  TextEditingController descriptionInArabic = TextEditingController();
  TextEditingController descriptionInEnglish = TextEditingController();
  // TextEditingController phoneNumber = TextEditingController();
  // TextEditingController whatsApp = TextEditingController();
  TextEditingController price = TextEditingController();
  int? categoryId;
  int? cityId;
  // int? bookTypeId;
  // int? usingTypeId;
  // LatLng? userLocation;
  // String? userAddress ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "addPlace".tr()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  currentStep: _index,
                  controlsBuilder: (context,controlsDetails){
                    if(controlsDetails.stepIndex != 3) {
                      return Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        text: "next".tr(),
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _index = _index +1;
                            setState(() {

                            });
                          }
                        },
                      ),
                    );
                    }else{
                      return BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                        if(state is !AddPlaceLoadingState){
                          return CustomButton(
                            text: "addPlace".tr(),
                            onPressed: ()async{
                              var result =  await ProfileCubit.get(context).addPlace(aboutAr: descriptionInArabic.text,aboutEn: descriptionInEnglish.text,categoryId: categoryId,cityId: cityId,price: price.text,nameAr: farmNameInArabic.text,nameEn: farmNameInEnglish.text);
                              if(result.statusCode == 200){
                                showToast(result.data["msg"]);
                                ProfileCubit.get(context).placeImages.clear();
                                ProfileCubit.get(context).amenitiesV1.clear();
                                HomeCubit.get(context).controller.jumpToTab(4);
                                dispose();
                              }else{
                                showToast(result.data["msg"]);
                              }
                            },
                          );
                        }else{
                          return customCircleProgressIndicator();
                        }
                      },);
                    }
                  },
                  onStepCancel: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_index <= 0) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        _index = index;
                      });
                    }
                  },
                  steps: [
                    Step(
                        title: Text("basicInformation".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("farmNameInArabic".tr()),
                              CustomTextField(
                                label: "farmNameInArabic".tr(),
                                textInputType: TextInputType.name,
                                controller: farmNameInArabic,
                                validator: (String? value){
                                  if(value!.isEmpty) {
                                    return "farmNameInArabicIsRequired".tr();
                                  }else{
                                    return null;
                                  }

                                },
                                hintColor: Colors.black,
                              ),
                              SizedBox(height: 10,),
                              Text("farmNameInEnglish".tr()),
                              CustomTextField(
                                label: "farmNameInEnglish".tr(),
                                textInputType: TextInputType.name,
                                controller: farmNameInEnglish,
                                validator: (String? value){
                                  if(value!.isEmpty) {
                                    return "farmNameInEnglishIsRequired".tr();
                                  }else{
                                    return null;
                                  }

                                },
                                hintColor: Colors.black,
                              ),
                              SizedBox(height: 10,),
                              Text("descriptionInArabic".tr()),
                              CustomTextField(
                                label: "descriptionInArabic".tr(),
                                textInputType: TextInputType.name,
                                controller: descriptionInArabic,
                                validator: (String? value){
                                  if(value!.isEmpty) {
                                    return "descriptionInArabicIsRequired".tr();
                                  }else{
                                    return null;
                                  }

                                },
                                hintColor: Colors.black,
                                lines: 5,
                              ),
                              SizedBox(height: 10,),
                              Text("descriptionInEnglish".tr()),
                              CustomTextField(
                                label: "descriptionInEnglish".tr(),
                                textInputType: TextInputType.name,
                                controller: descriptionInEnglish,
                                validator: (String? value){
                                  if(value!.isEmpty) {
                                    return "descriptionInEnglishIsRequired".tr();
                                  }else{
                                    return null;
                                  }

                                },
                                hintColor: Colors.black,
                                lines: 5,
                              ),
                              // SizedBox(height: 10,),
                              // Text("phoneNumber".tr()),
                              // CustomTextField(
                              //   label: "phoneNumber".tr(),
                              //   textInputType: TextInputType.number,
                              //   controller: phoneNumber,
                              //   fillColor: Colors.white,
                              //   textColor: Colors.black,
                              //   validator: (String? value){
                              //     if(value!.isEmpty) {
                              //       return "phoneNumberIsRequired".tr();
                              //     }else{
                              //       return null;
                              //     }
                              //
                              //   },
                              //   hintColor: Colors.black,
                              // ),
                              // SizedBox(height: 10,),
                              // Text("whatsApp".tr()),
                              // CustomTextField(
                              //   label: "whatsApp".tr(),
                              //   textInputType: TextInputType.number,
                              //   controller: whatsApp,
                              //   fillColor: Colors.white,
                              //   textColor: Colors.black,
                              //   validator: (String? value){
                              //     if(value!.isEmpty) {
                              //       return "whatsAppIsRequired".tr();
                              //     }else{
                              //       return null;
                              //     }
                              //
                              //   },
                              //   hintColor: Colors.black,
                              // ),
                              SizedBox(height: 10,),
                              Text("price".tr()),
                              CustomTextField(
                                label: "price".tr(),
                                textInputType: TextInputType.number,
                                controller: price,
                                validator: (String? value){
                                  if(value!.isEmpty) {
                                    return "priceIsRequired".tr();
                                  }else{
                                    return null;
                                  }

                                },
                                hintColor: Colors.black,
                              ),
                              // SizedBox(height: 10,),
                              // BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                              //   return Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text("numberOfVisitors".tr(),style: TextStyle(fontSize: 14),),
                              //       Row(
                              //         children: [
                              //           InkWell(
                              //               onTap: () {
                              //                 ProfileCubit.get(context).decrementCounter();
                              //               },
                              //               child: Container(
                              //                 decoration: BoxDecoration(color: kAppSecondColor,borderRadius: BorderRadius.circular(3)),
                              //                 child: Center(
                              //                   child: Icon(
                              //                     Icons.remove,
                              //                     color: Colors.white,
                              //                   ),
                              //                 ),
                              //               )),
                              //           Padding(
                              //             padding: const EdgeInsets.symmetric(horizontal: 10),
                              //             child: Text(
                              //               ProfileCubit.get(context).visitorNumber.toString(),
                              //               style: TextStyle(
                              //                 color: Colors.black,
                              //                 fontSize: 16,
                              //               ),
                              //             ),
                              //           ),
                              //           InkWell(
                              //               onTap: () {
                              //                 ProfileCubit.get(context).increaseCounter();
                              //               },
                              //               child: Container(
                              //                 decoration: BoxDecoration(color: kAppSecondColor,borderRadius: BorderRadius.circular(3)),
                              //                 child: Center(
                              //                   child: Icon(
                              //                     Icons.add,
                              //                     color: Colors.white,
                              //                   ),
                              //                 ),
                              //               )),
                              //         ],
                              //       ),
                              //     ],);
                              // },)
                            ],
                          ),
                        ),
                    ),
                    Step(
                      isActive: false,
                        title: Text("images".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                      content: Column(
                        children: [
                         BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                           return Wrap(
                               children: ProfileCubit.get(context).placeImages.map((e){
                                 return Image.file(File(e.path),fit: BoxFit.cover,width: 70,height: 70,);
                               }).toList()
                           );
                         },),
                          SizedBox(height: 10,),
                          TextButton(onPressed: (){
                         ProfileCubit.get(context).selectPlaceImages();
                          }, child: Text("${"selectImages".tr()} +"))
                        ],
                      )

                    ),
                    Step(
                      isActive: false,
                      title: Text("categories".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                      content: Column(
                        children: [
                          BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                            if(state is !GetCategoriesLoadingState){
                              return  Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton(
                                  value: categoryId,
                                  onChanged: (int? value) {
                                    categoryId = value;
                                    ProfileCubit.get(context).emit(AddPlaceRefreshState());
                                  },
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  icon: Container(
                                    color: Colors.black,
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  hint: Text("category".tr(),style: TextStyle(color: Colors.black,fontSize: 14),),
                                  items: ProfileCubit.get(context).categoriesModel!.data!.map((e){
                                    return DropdownMenuItem(child: Text(e.name!),value: e.id,);
                                  }).toList(),
                                ),
                              );
                            }else{
                              return SizedBox();
                            }

                          },),
                          SizedBox(height: 10,),
                          // BlocBuilder<PlacesCubit,PlacesStates>(builder: (context, state) {
                          //   if(state is !GetBookTypeLoadingState){
                          //     return  Container(
                          //       color: Colors.white,
                          //       padding: EdgeInsets.symmetric(horizontal: 10),
                          //       child: DropdownButton(
                          //         value: bookTypeId,
                          //         onChanged: (int? value) {
                          //           bookTypeId = value;
                          //           PlacesCubit.get(context).emit(PlacesRefreshState());
                          //         },
                          //         underline: SizedBox(),
                          //         isExpanded: true,
                          //         icon: Container(
                          //           color: Colors.black,
                          //           child: Icon(Icons.keyboard_arrow_down),
                          //         ),
                          //         borderRadius: BorderRadius.circular(5),
                          //         hint: Text("bookType".tr().tr(),style: TextStyle(color: Colors.black,fontSize: 14),),
                          //         items: PlacesCubit.get(context).bookTypeModel!.data!.map((e){
                          //           return DropdownMenuItem(child: Text(e.name!),value: e.id,);
                          //         }).toList(),
                          //       ),
                          //     );
                          //   }else{
                          //     return SizedBox();
                          //   }
                          //
                          // },),
                          // SizedBox(height: 10,),
                          // BlocBuilder<PlacesCubit,PlacesStates>(builder: (context, state) {
                          //   if(state is !GetUsingTypeLoadingState){
                          //     return  Container(
                          //       color: Colors.white,
                          //       padding: EdgeInsets.symmetric(horizontal: 10),
                          //       child: DropdownButton(
                          //         value: usingTypeId,
                          //         onChanged: (int? value) {
                          //           usingTypeId = value;
                          //           PlacesCubit.get(context).emit(PlacesRefreshState());
                          //         },
                          //         underline: SizedBox(),
                          //         isExpanded: true,
                          //         icon: Container(
                          //           color: Colors.black,
                          //           child: Icon(Icons.keyboard_arrow_down),
                          //         ),
                          //         borderRadius: BorderRadius.circular(5),
                          //         hint: Text("usingType".tr(),style: TextStyle(color: Colors.black,fontSize: 14),),
                          //         items: PlacesCubit.get(context).usingTypeModel!.data!.map((e){
                          //           return DropdownMenuItem(child: Text(e.name!),value: e.id,);
                          //         }).toList(),
                          //       ),
                          //     );
                          //   }else{
                          //     return SizedBox();
                          //   }
                          //
                          // },),
                        ],
                      ),
                    ),
                    // Step(
                    //   isActive: false,
                    //   title: Text("location&Map".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                    //   content: Column(
                    //     children: [
                    //       BlocBuilder<HomeCubit,HomeStates>(builder: (context, state) {
                    //         if(state is !GetGovernoratesLoadingState){
                    //           return  Container(
                    //             color: Colors.white,
                    //             padding: EdgeInsets.symmetric(horizontal: 10),
                    //             child: DropdownButton(
                    //               value: cityId,
                    //               onChanged: (int? value) {
                    //                 cityId = value;
                    //                 HomeCubit.get(context).emit(HomeRefreshState());
                    //               },
                    //               underline: SizedBox(),
                    //               isExpanded: true,
                    //               icon: Container(
                    //                 color: Colors.black,
                    //                 child: Icon(Icons.keyboard_arrow_down),
                    //               ),
                    //               borderRadius: BorderRadius.circular(5),
                    //               hint: Text("city".tr(),style: TextStyle(color: Colors.black,fontSize: 14),),
                    //               items: HomeCubit.get(context).governoratesModel!.data!.map((e){
                    //                 return DropdownMenuItem(child: Text(e.name!),value: e.id,);
                    //               }).toList(),
                    //             ),
                    //           );
                    //         }else{
                    //           return SizedBox();
                    //         }
                    //
                    //       },),
                    //       SizedBox(height: 15,),
                    //       Container(
                    //         width: double.maxFinite,
                    //         decoration: BoxDecoration(
                    //             color: kAppSecondColor,
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: MaterialButton(
                    //             height: 40,
                    //             onPressed: () async{
                    //               LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       PlacePicker(googleMapsApiKey,)));
                    //               userAddress = result.name;
                    //               userLocation = result.latLng;
                    //               showToast("locationAddedSuccessfully".tr());
                    //
                    //             },
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Center(
                    //                     child: Text(
                    //                       "selectLocation".tr(),
                    //                       style: TextStyle(
                    //                           color: Colors.white,
                    //                           fontSize: 12,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Image.asset("assets/images/location_white.png")
                    //               ],
                    //             )),
                    //       ),
                    //
                    //     ],
                    //   )
                    // ),
                    Step(
                      isActive: false,
                        title: Text("amenities".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                        content: Column(
                          children: [
                            BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                              return Wrap(
                                  children: List.generate(ProfileCubit.get(context).amenitiesV1.length, (index) => Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(ProfileCubit.get(context).amenitiesV1[index].name!),
                                        IconButton(onPressed: (){
                                          ProfileCubit.get(context).amenitiesV1[index].status = false;
                                          ProfileCubit.get(context).amenitiesV1.remove(ProfileCubit.get(context).amenitiesV1[index]);
                                          ProfileCubit.get(context).amenitiesV1Ids.remove(ProfileCubit.get(context).placesAttributesV1Model!.data![index].id!);
                                          ProfileCubit.get(context).emit(AddPlaceRefreshState());
                                        }, icon: Icon(Icons.clear))
                                      ],
                                    ),
                                  ))

                              );
                            },),
                            SizedBox(height: 10,),
                            BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) => TextButton(onPressed: (){
                              showModalBottomSheet(context: context, builder:(context) => Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                     return  Row(
                                        children: [
                                          StatefulBuilder(builder: (context, setState) {
                                            return Expanded(
                                              child: CheckboxListTile(value: ProfileCubit.get(context).placesAttributesV1Model!.data![index].status, onChanged: (value){
                                                if(value!){
                                                  ProfileCubit.get(context).amenitiesV1.add(ProfileCubit.get(context).placesAttributesV1Model!.data![index]);
                                                  ProfileCubit.get(context).amenitiesV1Ids.add(ProfileCubit.get(context).placesAttributesV1Model!.data![index].id!);
                                                }else{
                                                  ProfileCubit.get(context).amenitiesV1.remove(ProfileCubit.get(context).placesAttributesV1Model!.data![index]);
                                                  ProfileCubit.get(context).amenitiesV1Ids.remove(ProfileCubit.get(context).placesAttributesV1Model!.data![index].id!);

                                                }
                                                ProfileCubit.get(context).placesAttributesV1Model!.data![index].status = value;
                                                setState(() {});
                                                ProfileCubit.get(context).emit(AddPlaceRefreshState());
                                              },title: Text(ProfileCubit.get(context).placesAttributesV1Model!.data![index].name!)),
                                            );
                                          },)
                                        ],
                                      );
                                    }, separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: ProfileCubit.get(context).placesAttributesV1Model!.data!.length),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                                    child: Row(
                                      children: [
                                      Expanded(
                                        child: CustomButton(
                                          text: "next".tr(),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: CustomButton(
                                            text: "cancel".tr(),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                    ],),
                                  ),
                                  SizedBox(height: 30,)
                                ],
                              ));
                            }, child: Text("${"addAmenities".tr()} +")))
                          ],
                        )
                    ),
                    // Step(
                    //   isActive: false,
                    //   title: Text("amenitiesDetails".tr(),style: TextStyle(color: Colors.black,fontSize: 12),),
                    //   content: Column(
                    //     children: [
                    //       BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) {
                    //         return Wrap(
                    //             children: List.generate(ProfileCubit.get(context).amenitiesV2.length, (index) => Container(
                    //               padding: EdgeInsets.symmetric(horizontal: 10),
                    //               margin: EdgeInsets.only(left: 5),
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(15),
                    //                 border: Border.all(color: Colors.black),
                    //               ),
                    //               child: Row(
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: [
                    //                   Text(ProfileCubit.get(context).amenitiesV2[index].name!),
                    //                   SizedBox(width: 5,),
                    //                   Text(ProfileCubit.get(context).amenitiesV2[index].controller!.text),
                    //                   IconButton(onPressed: (){
                    //                     ProfileCubit.get(context).amenitiesV2.remove(ProfileCubit.get(context).amenitiesV2[index]);
                    //                     ProfileCubit.get(context).amenitiesV2Objects.remove({
                    //                       "id" : ProfileCubit.get(context).amenitiesV2[index].id,
                    //                       "value" : ProfileCubit.get(context).amenitiesV2[index].controller!.text
                    //                     });
                    //                     ProfileCubit.get(context).emit(AddPlaceRefreshState());
                    //                   }, icon: Icon(Icons.clear))
                    //                 ],
                    //               ),
                    //             ))
                    //
                    //         );
                    //       },),
                    //       SizedBox(height: 10,),
                    //       BlocBuilder<ProfileCubit,ProfileStates>(builder: (context, state) => TextButton(onPressed: (){
                    //         showModalBottomSheet(context: context, builder:(context) => StatefulBuilder(
                    //           builder: (context , setState) {
                    //             return Padding(
                    //               padding: const EdgeInsets.all(20),
                    //               child: Column(
                    //                 children: [
                    //                   Expanded(
                    //                     child: ListView.separated(
                    //                         itemBuilder: (context, index) {
                    //                           return  Column(
                    //                             crossAxisAlignment: CrossAxisAlignment.start,
                    //                             children: [
                    //                               Text(ProfileCubit.get(context).placesAttributesV2Model!.data![index].name!),
                    //                               CustomTextField(
                    //                                 label: ProfileCubit.get(context).placesAttributesV2Model!.data![index].name,
                    //                                 controller:  ProfileCubit.get(context).placesAttributesV2Model!.data![index].controller,
                    //                                 textColor: Colors.black,
                    //                                 hintColor: Colors.black,
                    //                                 onChanged: (String? value){
                    //                                   ProfileCubit.get(context).placesAttributesV2Model!.data![index].controller!.text = value!;
                    //                                   ProfileCubit.get(context).amenitiesV2.add(ProfileCubit.get(context).placesAttributesV2Model!.data![index]);
                    //                                 },
                    //                                 fillColor: Colors.white,
                    //                                 textInputType: TextInputType.number,
                    //                               )
                    //                             ],
                    //                           );
                    //                         }, separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: ProfileCubit.get(context).placesAttributesV2Model!.data!.length),
                    //                   ),
                    //                   Row(
                    //                     children: [
                    //                       Expanded(
                    //                         child: CustomButton(
                    //                           text: "next".tr(),
                    //                           onPressed: (){
                    //                        setState(() {});
                    //                        ProfileCubit.get(context).emit(AddPlaceRefreshState());
                    //                        Navigator.pop(context);
                    //                           },
                    //                         ),
                    //                       ),
                    //                       SizedBox(width: 10,),
                    //                       Expanded(
                    //                         child: CustomButton(
                    //                           text: "cancel".tr(),
                    //                           onPressed: (){
                    //                             Navigator.pop(context);
                    //                           },
                    //                         ),
                    //                       ),
                    //                     ],)
                    //                 ],
                    //               ),
                    //             );
                    //           }
                    //         ));
                    //       }, child: Text("${"addAmenitiesDetails".tr()} +")))
                    //     ],
                    //   )
                    //
                    // ),
                  ],

                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
