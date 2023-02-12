import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/app/models/appointment.dart';
import 'package:mind_space/shared/components/component.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class Appointment extends StatelessWidget {
  Appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorStates>(
      listener: (context, state) {
        if(state is ChangeStatusSuccessState){
          DoctorCubit.getCubit(context).getAllOfflineAppointment();
          DoctorCubit.getCubit(context).getAllOnlineAppointment();
        }
      },
      builder: (context, state) {
        var cubit = DoctorCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColorManager.background,
            body: ConditionalBuilder(
              condition: cubit.doctorModel!=null,
              builder: (context) =>  Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Row(children: [
                        Text("Welcome",
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSizeManager.s24)),
                        const Spacer(),
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(cubit.doctorModel!.image!),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: TabBar(
                      labelColor: Colors.red,
                      isScrollable: true,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.red,
                      indicatorPadding: EdgeInsets.all(15),
                      physics: BouncingScrollPhysics(),
                      tabs: [
                        Tab(text: "Online"),
                        Tab(text: "At clinic"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TabBarView(
                          children: [ConditionalBuilder(
                            condition: cubit.onlineAppointmentList.isNotEmpty,
                            builder: (context) => onlineAppListView(context),
                            fallback: (context) => SizedBox(
                              child: Center(
                                child: Text(
                                  'There is no online appointment yet',
                                  style: getRegularStyle(
                                      color: ColorManager.gray, fontSize: 16),
                                ),
                              ),
                            ),
                          ), ConditionalBuilder(
                            condition: cubit.offlineAppointmentList.isNotEmpty,
                            builder: (context) => offlineAppListView(context),
                            fallback: (context) => SizedBox(
                              child: Center(
                                child: Text(
                                  'There is no at clinic appointment yet',
                                  style: getRegularStyle(
                                      color: ColorManager.gray, fontSize: 16),
                                ),
                              ),
                            ),
                          )]),
                    ),
                  ),
                ],
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: ColorManager.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget onlineAppListView(context) {
    var cubit = DoctorCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return onlineItemBuilder(context,cubit.onlineAppointmentList[index],index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.onlineAppointmentList.length,
          ),
        ],
      ),
    );
  }

  Widget offlineAppListView(context) {
    var cubit = DoctorCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return offlineItemBuilder(context,cubit.offlineAppointmentList[index],index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.offlineAppointmentList.length,
          ),
        ],
      ),
    );
  }

  Widget onlineItemBuilder(context,AppointmentModel model,index) {
    return InkWell(
      onTap: () {
        showAppointmentDialog(context,model,index);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          "Individual session",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          "${model.date}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                Container(
                  color: ColorManager.primary,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        "View",
                        style: getSemiBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSizeManager.s14),
                      ),
                      Icon(
                        IconBroken.Arrow___Right_2,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  Widget offlineItemBuilder(context,AppointmentModel model,index) {
    return InkWell(
      onTap: () {
        showAppointmentDialog(context,model,index);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          "Individual session",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          "${model.date}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                Container(
                  color: ColorManager.primary,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        "View",
                        style: getSemiBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSizeManager.s14),
                      ),
                      Icon(
                        IconBroken.Arrow___Right_2,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future showAppointmentDialog(context,AppointmentModel model,index){
    var cubit  = DoctorCubit.getCubit(context);
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: ImageIcon(AssetImage(ImageAssets.point),
                        size: 12,
                        color: ColorManager.error,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Individual session",
                  style: getBoldStyle(
                      color: ColorManager.darkGray, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "${model.studentNickname}",
                  style: getSemiBoldStyle(
                      color: ColorManager.darkGray, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${model.date}",
                  style: getSemiBoldStyle(
                      color: ColorManager.darkGray, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${model.time}",
                  style: getSemiBoldStyle(
                      color: ColorManager.darkGray, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.green)),
                      onPressed: () {
                        if(model.status== 'Processing'){
                          cubit.changeAppointmentStatus(appointmentType: model.type!, index: index, status: 'Accepted');
                          Navigator.pop(context);
                          toast(message: 'Appointment Accepted successfully', data: ToastStates.success);
                        }
                      },
                      child: Text(
                        "Accept",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        if(model.status == 'Processing'){
                          cubit.changeAppointmentStatus( appointmentType: model.type!,index:  index,status: 'Rejected');
                          Navigator.pop(context);
                          toast(message: 'Appointment Rejected successfully', data: ToastStates.success);
                        }
                      },
                      child: model.status=='Rejected'?
                      Text(
                        "Rejected",
                        style: getRegularStyle(color: ColorManager.white),
                      ):
                      Text(
                        "Reject",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
