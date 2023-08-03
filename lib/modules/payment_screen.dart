import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/order_cubit/order_cubit.dart';
import 'package:mazraaty/cubits/order_cubit/order_states.dart';
import 'package:mazraaty/modules/auth_screens/login_screen.dart';

import '../cubits/places_cubit/places_cubit.dart';
import '../networks/local/cache_helper.dart';
import '../shared/components.dart';
import '../shared/constants.dart';
import '../shared/custom_button.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    OrderCubit.get(context).getPaymentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
            context: context, title: "chooseYourPaymentMethod".tr()),
        body: BlocBuilder<OrderCubit, OrderStates>(
          builder: (context, state) {
            if (OrderCubit.get(context).paymentModel != null) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("pleaseSelectAPaymentMethod".tr()),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/zaincash.png"))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("clickToCopyZainCashNumber".tr()),
                            InkWell(
                              onTap: () async {
                                await FlutterClipboard.copy(
                                    OrderCubit.get(context)
                                        .paymentModel!
                                        .data!
                                        .zainNumber!);
                                showToast("copyDone".tr());
                              },
                              child: Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(OrderCubit.get(context)
                                      .paymentModel!
                                      .data!
                                      .zainNumber!),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/bank.png"))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("transferToUnionBankAccount".tr()),
                            InkWell(
                              onTap: () async {
                                await FlutterClipboard.copy(
                                    OrderCubit.get(context)
                                        .paymentModel!
                                        .data!
                                        .bankAcountNumber!);
                                showToast("copyDone".tr());
                              },
                              child: Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(OrderCubit.get(context)
                                      .paymentModel!
                                      .data!
                                      .bankAcountNumber!),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    BlocBuilder<OrderCubit, OrderStates>(
                        builder: (context, state) {
                      if (state is! MakeOrderLoadingState) {
                        return CustomButton(
                          color: kAppSecondColor,
                          onPressed: () async {
                            final token = CacheHelper.getData("userToken");
                            if (token != null) {
                              var result = await OrderCubit.get(context)
                                  .makeOrder(PlacesCubit.get(context)
                                      .placeModel!
                                      .data!
                                      .id);
                              if (result["status"]) {
                                OrderCubit.get(context).isRated = false;
                                navigateTo(
                                    context: context,
                                    page: ConfirmationScreen(
                                      placeId: PlacesCubit.get(context)
                                          .placeModel!
                                          .data!
                                          .id,
                                      orderId: result["data"]["order_id"],
                                    ));
                              } else {
                                showToast(result["msg"]);
                              }
                            } else {
                              navigateAndFinish(context, LoginScreen());
                            }
                          },
                          text: "confirmReservation".tr(),
                          textColor: Colors.white,
                        );
                      } else {
                        return customCircleProgressIndicator();
                      }
                    }),
                  ],
                ),
              );
            } else {
              return customCircleProgressIndicator();
            }
          },
        ));
  }
}
