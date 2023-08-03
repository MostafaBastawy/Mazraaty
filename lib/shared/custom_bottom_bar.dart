//
// import 'package:easy_localization/src/public_ext.dart';
// import 'package:ezr3_eraq/cubits/home_layout_cubit/home_layout_cubit.dart';
// import 'package:ezr3_eraq/cubits/home_layout_cubit/home_layout_states.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import 'constants.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeLayoutCubit,HomeLayoutStates>(
//       builder: (context, state) {
//         HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
//         return ClipRRect(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
//           child: BottomAppBar(
//             shape: const CircularNotchedRectangle(),
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               elevation: 0,
//               backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
//               selectedItemColor: kAppColor,
//               currentIndex: cubit.selectedIndex,
//               onTap: (value) {
//                 cubit.changeHomeNavBar(value,context: context);
//               },
//               items: [
//                 BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'.tr().tr()),
//                 BottomNavigationBarItem(icon: SvgPicture.asset("assets/images/bottom 2.svg",width: 20,), label: 'companies'.tr(),activeIcon: SvgPicture.asset("assets/images/bottom 2.svg",width: 20,color: kAppColor,)),
//                 BottomNavigationBarItem(icon: SizedBox(), label: ''),
//                 BottomNavigationBarItem(icon: SvgPicture.asset("assets/images/bottom 4.svg",width: 20,), label: 'explain'.tr(),activeIcon: SvgPicture.asset("assets/images/bottom 4.svg",width: 20,color: kAppColor,)),
//                 BottomNavigationBarItem(icon: SvgPicture.asset("assets/images/bottom 5.svg",width: 20,), label: 'myProfile'.tr(),activeIcon: SvgPicture.asset("assets/images/bottom 5.svg",width: 20,color: kAppColor,)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
