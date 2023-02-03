import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';
import '../../../styles/icons_broken.dart';
import '../../models/appointment.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../home/home_student_cubit/cubit.dart';

class PreviousSession extends StatefulWidget {
  const PreviousSession({Key? key}) : super(key: key);

  @override
  State<PreviousSession> createState() => _PreviousSessionState();
}

class _PreviousSessionState extends State<PreviousSession> {
  @override
  void initState() {
    StudentCubit.getCubit(context).getAllOfflinePreviousAppointment();
    StudentCubit.getCubit(context).getAllOnlinePreviousAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {
        if (state is GetDoctorForRateSuccessState) {
          StudentCubit.getCubit(context)
              .Rate(StudentCubit.getCubit(context).rate!);
        }
        if (state is ChangeRateStatusSuccessState) {
          StudentCubit.getCubit(context).getAllOfflinePreviousAppointment();
          StudentCubit.getCubit(context).getAllOnlinePreviousAppointment();
        }
      },
      builder: (context, state) {
        var cubit = StudentCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Previous Session'),
            ),
            backgroundColor: ColorManager.background,
            body: Column(
              children: [
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
                      children: [
                        ConditionalBuilder(
                          condition: cubit.onlineAppointmentList.isNotEmpty,
                          builder: (context) {
                            return onlineAppListView(context);
                          },
                          fallback: (context) => SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: Text(
                                'There is no online appointment',
                                style: getRegularStyle(
                                    color: ColorManager.gray, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: cubit.offlineAppointmentList.isNotEmpty,
                          builder: (context) {
                            return offlineAppListView(context);
                          },
                          fallback: (context) => SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: Text(
                                'There is no at clinic appointment',
                                style: getRegularStyle(
                                    color: ColorManager.gray, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget onlineAppListView(context) {
    var cubit = StudentCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return onlineItemBuilder(
                    cubit.onlineAppointmentList[index], context, index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.onlineAppointmentList.length),
        ],
      ),
    );
  }

  Widget offlineAppListView(context) {
    var cubit = StudentCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return offlineItemBuilder(
                    cubit.offlineAppointmentList[index], context, index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.offlineAppointmentList.length),
        ],
      ),
    );
  }

  Widget onlineItemBuilder(AppointmentModel model, context, index) {
    return InkWell(
      onTap: () {
        showAppointmentDialog(model, context, index);
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${model.status}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${model.type}",
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
                const SizedBox(
                  height: 5,
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

  Widget offlineItemBuilder(AppointmentModel model, context, index) {
    return InkWell(
      onTap: () {
        showAppointmentDialog(model, context, index);
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Status ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${model.status}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${model.type}",
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
                const SizedBox(
                  height: 5,
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

  Future showAppointmentDialog(AppointmentModel model, context, index) {
    var cubit = StudentCubit.getCubit(context);
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
                    ImageIcon(
                      AssetImage(ImageAssets.point),
                      size: 12,
                      color: ColorManager.error,
                    ),
                  ],
                ),
                Text(
                  "Individual session",
                  style:
                      getBoldStyle(color: ColorManager.darkGray, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
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
                if (model.status == 'Finished')
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doctor report : ",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                          Text(
                            '${model.doctorReport}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (model.status == 'Finished')
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Review Doctor : ",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                          RatingBar.builder(
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (value) {
                              cubit.changeRate(value);
                            },
                            minRating: 3,
                            initialRating: cubit.rate == null ? 0 : cubit.rate!,
                            ignoreGestures: model.isRated!,
                            allowHalfRating: true,
                            updateOnDrag: true,
                            unratedColor: Colors.grey,
                            glowColor: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (model.status == 'Finished')
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
                          if (cubit.rate != null) {
                            cubit.getRateDoctor(model.doctorId!, cubit.rate!,
                                index, model.type!);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "save",
                          style: getRegularStyle(color: ColorManager.white),
                        ),
                      ),
                    SizedBox(
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
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
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
