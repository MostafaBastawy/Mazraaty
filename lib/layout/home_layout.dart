import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/home_cubit/home_cubit.dart';
import 'package:mazraaty/cubits/home_cubit/home_states.dart';
import 'package:mazraaty/modules/favourites_screen.dart';
import 'package:mazraaty/modules/notifications_screen.dart';
import 'package:mazraaty/modules/settings_screen.dart';
import 'package:mazraaty/shared/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../modules/add_place_screen.dart';
import '../modules/home_screen.dart';

class HomeLayout extends StatelessWidget {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      FavouritesScreen(),
      AddPlaceScreen(),
      NotificationScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/nav1.png",
          color: kAppColor,
        ),
        title: "home".tr(),
        inactiveIcon: Image.asset("assets/images/nav1.png"),
        activeColorPrimary: kAppColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/nav2.png",
          color: kAppColor,
        ),
        title: "favourite".tr(),
        inactiveIcon: Image.asset("assets/images/nav2.png"),
        activeColorPrimary: kAppColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        title: "",
        inactiveIcon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        activeColorPrimary: kAppColor,
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/nav3.png",
          color: kAppColor,
        ),
        title: "notifications".tr(),
        activeColorPrimary: kAppColor,
        inactiveIcon: Image.asset("assets/images/nav3.png"),
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/nav4.png",
          color: kAppColor,
        ),
        title: "settings".tr(),
        activeColorPrimary: kAppColor,
        inactiveIcon: Image.asset(
          "assets/images/nav4.png",
        ),
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return PersistentTabView(context,
            controller: HomeCubit.get(context).controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            resizeToAvoidBottomInset: true,
            backgroundColor: kAppSecondColor, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                colorBehindNavBar: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2), offset: Offset(1, 4))
                ]),
            margin: EdgeInsets.zero,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarHeight: 80,
            navBarStyle: NavBarStyle
                .style18 // Choose the nav bar style with this property.
            );
      },
    );
  }
}
