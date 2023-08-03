
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/cubits/home_cubit/home_cubit.dart';
import 'package:mazraaty/cubits/home_cubit/home_states.dart';


import '../shared/components.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    HomeCubit.get(context).getUserNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "notifications".tr()),
      body: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context, state){
          HomeCubit cubit = HomeCubit.get(context);
          if(cubit.notificationsModel != null){
            return ListView.builder(itemCount:cubit.notificationsModel!.data!.length,itemBuilder: (context, index) => buildNotificationItem(context,cubit.notificationsModel!.data![index]));
          }else{
            return customCircleProgressIndicator();
          } },
      )

    );
  }

  Widget buildNotificationItem(context, model) =>  ListTile(
    leading: CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black,
    ),
    title: Text(model.placeName),
    subtitle: Text(model.message),
  );
}
