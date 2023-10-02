import 'package:clipboard/clipboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mazraaty/cubits/order_cubit/order_states.dart';
import 'package:mazraaty/shared/custom_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../cubits/order_cubit/order_cubit.dart';
import '../shared/components.dart';

class ConfirmationScreen extends StatelessWidget {
  final int? orderId;
  final int? placeId;
  ConfirmationScreen({Key? key, this.orderId, required this.placeId})
      : super(key: key);

  double rating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "done".tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "theReservationRequestHasBeenSentToTheApplicationAdministrationPleaseSendTheReservationCodeAndTheTransferReceiptOnWhatsAppFromThroughTheFollowingButton"
                    .tr(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                "clickOnTheCodeToCopyTheReservationCode".tr(),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await FlutterClipboard.copy(orderId.toString());
                  showToast("copyDone".tr());
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.grey.withOpacity(0.2),
                  child: Center(
                      child: Text(
                    orderId.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await launchUrlString(
                    'https://wa.me/962795030373',
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xfff25D366),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                        // ],
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                          "sendRemittanceReceipt".tr(),
                          style: TextStyle(color: Colors.white),
                        ))),
                        SvgPicture.asset(
                          "assets/images/whatsapp.svg",
                          color: Colors.white,
                          width: 50,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              BlocConsumer<OrderCubit, OrderStates>(
                listener: (context, state) {
                  if (state is RatePlaceSuccessState) {
                    showToast(state.rateModel!.msg);
                  }
                },
                builder: (context, state) {
                  OrderCubit orderCubit = OrderCubit.get(context);
                  return orderCubit.isRated
                      ? SizedBox()
                      : Column(
                          children: [
                            StatefulBuilder(
                              builder: (context, setState) => RatingBar.builder(
                                initialRating: rating,
                                minRating: 1,
                                glowColor: const Color(0xffF3E184),
                                unratedColor: const Color(0xffCFD8DC),
                                itemSize: 40,
                                itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 5),
                                onRatingUpdate: (value) {
                                  rating = value;
                                  setState(() {});
                                },
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star_rate_rounded,
                                  color: Color(0xffFECE00),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: commentController,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: "comment".tr(),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            SizedBox(height: 20),
                            state is RatePlaceLoadingState
                                ? customCircleProgressIndicator()
                                : CustomButton(
                                    text: "addRate".tr(),
                                    onPressed: () async {
                                      await OrderCubit.get(context).ratePlace(
                                          rate: rating.toString(),
                                          comment: commentController.text,
                                          id: 1);
                                      // Navigator.pop(context);
                                    },
                                  ),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
