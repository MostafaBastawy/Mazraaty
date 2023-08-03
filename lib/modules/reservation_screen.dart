import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/order_cubit/order_cubit.dart';
import 'package:mazraaty/cubits/order_cubit/order_states.dart';
import 'package:mazraaty/modules/payment_screen.dart';
import 'package:mazraaty/shared/components.dart';
import 'package:table_calendar/table_calendar.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
import '../cubits/auth_cubit/auth_states.dart';
import '../cubits/places_cubit/places_cubit.dart';
import '../shared/constants.dart';
import '../shared/custom_button.dart';

class ReservationScreen extends StatelessWidget {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    OrderCubit.get(context).day = 1;
    OrderCubit.get(context).total = PlacesCubit.get(context).placeModel!.data!.price!;
    return Scaffold(
      appBar: customAppbar(context: context, title: "reservation".tr()),
      body:BlocBuilder<OrderCubit,OrderStates>(
        builder: (context, state) {
          return  Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text("iRequestedAFarmReservationWithTheFollowingSpecifications".tr()),
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
                TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  calendarFormat: _calendarFormat,

                  onFormatChanged: (format) {
                    _calendarFormat = format;
                    OrderCubit.get(context).emit(OrderRefreshState());
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    _selectedDay = selectedDay;
                    OrderCubit.get(context).focusedDay = focusedDay;
                    OrderCubit.get(context).emit(OrderRefreshState());
                    var result = await OrderCubit.get(context).checkDate(PlacesCubit.get(context).placeModel!.data!.id, focusedDay.toString());
                    if(result["status"]){
                      showToast(result["msg"]);
                    }else{
                      showToast(result["msg"]);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    OrderCubit.get(context).focusedDay = focusedDay;
                  },
                  onCalendarCreated: (pageController) {
                    // HomeCubit.get(context)
                    //     .getAlerts(_focusedDay.toString());
                  },
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: OrderCubit.get(context).focusedDay,
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("reservationDays".tr()),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: () {
                          OrderCubit.get(context).decrementCounter();
                          OrderCubit.get(context).total = PlacesCubit.get(context).placeModel!.data!.price! * OrderCubit.get(context).day ;

                        },
                        child: Container(
                          decoration: BoxDecoration(color: kAppColor,borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${OrderCubit.get(context).day}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          OrderCubit.get(context).increaseCounter();
                          OrderCubit.get(context).total = PlacesCubit.get(context).placeModel!.data!.price! * OrderCubit.get(context).day ;
                        },
                        child: Container(
                          decoration: BoxDecoration(color: kAppColor,borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Spacer(),
                    Text("${ OrderCubit.get(context).day}X${PlacesCubit.get(context).placeModel!.data!.price}"),



                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("total".tr()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("${OrderCubit.get(context).total} "),
                        Text("dinar".tr(), style: TextStyle(color: Colors.grey),),

                      ],
                    )],
                ),
                SizedBox(height: 10,),
                BlocBuilder<AuthCubit,AuthStates>(
                    builder:(context, state) {
                      if(state is !UserRegisterLoadingState){
                        return CustomButton(
                          color: kAppSecondColor,
                          onPressed: () async {
                            navigateTo(context: context, page: PaymentScreen());
                          },
                          text: "continueToPayment".tr(),
                          textColor: Colors.white,

                        );
                      } else{
                        return customCircleProgressIndicator();
                      }
                    }
                ),

              ],
            ),
          );
        },
      )
    );
  }
}
