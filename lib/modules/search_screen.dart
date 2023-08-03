import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/home_cubit/home_cubit.dart';
import 'package:mazraaty/shared/components.dart';
import 'package:mazraaty/shared/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../cubits/filter_cubit/filter_cubit.dart';
import '../cubits/filter_cubit/filter_states.dart';
import 'filter_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  int selectedIndex = 0;

  bool isLowestPrice = true;

  int? countryId;

  @override
  void initState() {
    // TODO: implement initState
    FilterCubit.get(context).getAllRegions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? categoryId = HomeCubit
        .get(context)
        .homeModel!
        .data!
        .categories![0].id;
    return BlocBuilder<FilterCubit, FilterStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: customAppbar(context: context, title: "mazraaty".tr()),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("chooseCategory".tr()),
                ),
                GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 3,
                  children: List.generate(HomeCubit
                      .get(context)
                      .homeModel!
                      .data!
                      .categories!
                      .length, (index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        categoryId = HomeCubit
                            .get(context)
                            .homeModel!
                            .data!
                            .categories![selectedIndex].id;
                        print(categoryId);
                        FilterCubit.get(context).emit(FilterRefreshState());
                      },
                      child: Container(
                        decoration: BoxDecoration(color: selectedIndex != index
                            ? Colors.white
                            : kAppColor,
                            border: Border.all(color: selectedIndex != index
                                ? Colors.black
                                : kAppColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text(HomeCubit
                            .get(context)
                            .homeModel!
                            .data!
                            .categories![index].name!, style: TextStyle(
                            color: selectedIndex != index
                                ? Colors.black
                                : Colors
                                .white),)),
                      ),
                    );
                  }),),
                state is! GetRegionsLoadingState ?
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: DropdownButton(
                    value: countryId,
                    onChanged: (int? value) {
                      countryId = value;
                      FilterCubit.get(context).emit(FilterRefreshState());
                    },
                    underline: SizedBox(),
                    isExpanded: true,
                    icon: Container(
                      color: Colors.black,
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    hint: Text("state".tr(),
                      style: TextStyle(color: Colors.black, fontSize: 14),),
                    items: FilterCubit
                        .get(context)
                        .regionsModel
                        .data!
                        .map((e) {
                      return DropdownMenuItem(child: Text(e.name!), value: e
                          .id,);
                    }).toList(),
                  ),
                ) : SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("chooseDate".tr()),
                ),
                TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  calendarFormat: _calendarFormat,

                  onFormatChanged: (format) {
                    _calendarFormat = format;
                    FilterCubit.get(context).emit(FilterRefreshState());
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    FilterCubit.get(context).emit(FilterRefreshState());
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  onCalendarCreated: (pageController) {
                    // HomeCubit.get(context)
                    //     .getAlerts(_focusedDay.toString());
                  },
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: Text("orderPriceBy".tr())),
                    InkWell(
                      onTap: () {
                        isLowestPrice = true;
                        FilterCubit.get(context).emit(FilterRefreshState());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: isLowestPrice ? kAppColor : Colors.white,
                            border: Border.all(
                                color: isLowestPrice ? kAppColor : Colors
                                    .black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text("lowest".tr(), style: TextStyle(
                                color: isLowestPrice ? Colors.white : Colors
                                    .black))),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        isLowestPrice = false;
                        FilterCubit.get(context).emit(FilterRefreshState());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: !isLowestPrice ? kAppColor : Colors.white,
                            border: Border.all(
                                color: !isLowestPrice ? kAppColor : Colors
                                    .black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text("highest".tr(), style: TextStyle(
                                color: !isLowestPrice ? Colors.white : Colors
                                    .black),)),
                      ),
                    )
                  ],),
                SizedBox(height: 50,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20,bottom: 10,top: 10),
                //   child: Row(
                //     children: [
                //       Expanded(child: Text("عدد الأشخاص ")),
                //       InkWell(
                //           onTap: () {
                //
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(color: kAppColor,borderRadius: BorderRadius.circular(3)),
                //             child: Center(
                //               child: Icon(
                //                 Icons.remove,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           )),
                //
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Text(
                //          "4",
                //           style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 16,
                //           ),
                //         ),
                //       ),
                //       InkWell(
                //           onTap: () {
                //
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(color: kAppColor,borderRadius: BorderRadius.circular(3)),
                //             child: Center(
                //               child: Icon(
                //                 Icons.add,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           )),
                //
                //   ],),
                // ),
                BlocBuilder<FilterCubit, FilterStates>(
                  builder: (context, state) {
                    if (state is! PlacesFilterLoadingState) {
                      return InkWell(
                        onTap: () async {
                          await FilterCubit.get(context).filterPlaces(
                              categoryId, _focusedDay.toString(),
                              isLowestPrice ? 1 : 2, countryId ?? null );
                          if (FilterCubit
                              .get(context)
                              .places!
                              .status!) {
                            navigateTo(context: context, page: FilterScreen());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              right: 50, bottom: 5, top: 5, left: 20),
                          decoration: BoxDecoration(
                            color: kAppColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("searchNow".tr(), style: TextStyle(
                                  color: Colors.white),),
                              Image.asset("assets/images/calender.png")
                            ],
                          ),
                        ),
                      );
                    } else {
                      return customCircleProgressIndicator();
                    }
                  },)
              ],
            ),
          );
        }
    );
  }

}
