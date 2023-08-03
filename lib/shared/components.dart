import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mazraaty/cubits/Favourite_cubit/favourite_states.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/Favourite_cubit/favourite_cubit.dart';
import '../modules/farm_details.dart';
import 'constants.dart';

Future<dynamic> navigateTo(
        {required BuildContext context, required Widget page}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

customAppbar(
        {required BuildContext context,
        required String title,
        bool navigate = false}) =>
    AppBar(
      elevation: 0,
      centerTitle: true,
      leading: navigate
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.back,
                color: Colors.black,
                size: 40,
              ),
            )
          : SizedBox(),
      backgroundColor: kAppColor,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );

Future<bool?> showToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kAppColor,
    textColor: Colors.white,
    fontSize: 16.0);

Widget customCircleProgressIndicator() => Center(
      child: CircularProgressIndicator(
        color: kAppColor,
      ),
    );

Widget buildProductItem(context, model) => Stack(
      alignment: Alignment.topLeft,
      children: [
        InkWell(
          onTap: () {
            navigateTo(
                context: context,
                page: PlaceDetailsScreen(
                  placeId: model.id,
                  placeName: model.name,
                ));
          },
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(model.image),
              ),
            ),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${model.name} ${model.price} ${"dinar".tr()}",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ),
        BlocBuilder<FavouriteCubit, FavouriteStates>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  FavouriteCubit.get(context).makeFavourite(model.id);
                  model.isFav = !model.isFav;
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    model.isFav ? Icons.favorite : Icons.favorite_border,
                    color: model.isFav
                        ? Colors.red
                        : Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );

//
// void launchURL(url) async{
// if (!await launch(url)) throw 'Could not launch $url';
// }
//
// void launchPhone(phoneNumber) async {
//   if (!await launch('tel:${phoneNumber}')) throw 'Could not launch $phoneNumber';
// }

void launchWhatsApp(phone) async {
  if (!await launch('https://wa.me/$phone'))
    throw 'Could not launch wa.me/$phone';
}

// Widget scanQrImage(context) => InkWell(
//   onTap: () async {
//     var result = await HomeCubit.get(context).scanQr();
//     if(result != "-1"){
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Qr Output"),
//             content: InkWell(
//                 onTap: (){
//                   navigateTo(context: context, page: QrScreen(url: result,
//                   ));
//                 },
//                 child: Text(result,style: TextStyle(decoration: TextDecoration.underline,fontSize: 20,color: Colors.blueAccent))),
//             actions: [
//               TextButton(
//                 child: Text("cancel".tr()),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               )
//             ],
//           );
//         },
//       );
//     }
//   },
//   child: Image.asset(
//     "assets/images/qrcode.png",
//     width: 30,
//   ),
// );

class LoadingImageContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final bool repeat;

  const LoadingImageContainer({
    Key? key,
    required this.width,
    required this.height,
    this.repeat = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: authBackgroundColor,
      highlightColor: highlightColor,
      loop: repeat ? 0 : 1,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: authBackgroundColor,
        ),
      ),
    );
  }
}
