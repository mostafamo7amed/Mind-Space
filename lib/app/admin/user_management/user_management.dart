import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/admin/home/home_cubit/cubit.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';
import 'package:mind_space/app/login/login_view.dart';
import 'package:mind_space/app/models/doctor.dart';
import 'package:mind_space/app/models/student.dart';
import 'package:mind_space/app/resources/color_manager.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';
import '../profile/view_personal_info.dart';

class UserManagement extends StatelessWidget {
  UserManagement({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //var cubit = AdminCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColorManager.background,
            appBar: AppBar(
              elevation: 0.0,
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    CacheHelper.removeData(key: 'uid');
                    navigateAndFinish(context, LoginView());
                  },
                  icon: const ImageIcon(
                    AssetImage(ImageAssets.shutdown),
                    size: 25,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          ImageAssets.wave,
                          height: 200,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      InkWell(
                        onTap: () => navigateTo(context, ViewAdminInfo()),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                  ImageAssets.photo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      Tab(text: "Student"),
                      Tab(text: "Doctor"),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: TabBarView(
                      children: [
                        ConditionalBuilder(
                          condition: AdminCubit.getCubit(context)
                              .studentModel
                              .isNotEmpty,
                          builder: (context) => studentListView(context),
                          fallback: (context) => SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                backgroundColor: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                        ConditionalBuilder(
                          condition: AdminCubit.getCubit(context)
                              .doctorModel
                              .isNotEmpty,
                          builder: (context) => doctorListView(context),
                          fallback: (context) => SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                backgroundColor: ColorManager.primary,
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

  Widget studentListView(context) {
    var cubit = AdminCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return studentItemBuilder(
                  cubit.studentModel[index], context, index);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
            ),
            itemCount: cubit.studentModel.length, // todo list students
          ),
        ],
      ),
    );
  }

  Widget doctorListView(context) {
    var cubit = AdminCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return doctorItemBuilder(
                    cubit.doctorModel[index], context, index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.doctorModel.length),
        ],
      ),
    );
  }

  Widget studentItemBuilder(Student model, context, index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 140,
                  child: Text(
                    "${model.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                onPressed: () {
                  showBlockInfoDialog(model, context, index, 'Student');
                },
                child: model.isBlocked!
                    ? Text(
                        "UnBlock",
                        style: getRegularStyle(color: ColorManager.white),
                      )
                    : Text(
                        "Block",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
              ),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlueAccent)),
                onPressed: () {
                  showStudentInfoDialog(model, context);
                },
                child: Text(
                  "View",
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )),
    );
  }

  Widget doctorItemBuilder(Doctor model, context, index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    "Dr. ${model.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                onPressed: () {
                  showBlockInfoDialog(model, context, index, 'Doctor');
                },
                child: model.isBlocked!
                    ? Text(
                        "UnBlock",
                        style: getRegularStyle(color: ColorManager.white),
                      )
                    : Text(
                        "Block",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
              ),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlueAccent)),
                onPressed: () {
                  showDoctorInfoDialog(model, context);
                },
                child: Text(
                  "View",
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )),
    );
  }

  Future showBlockInfoDialog(model, context, index, userType) => showDialog(
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
                    "Warning",
                    style: getBoldStyle(
                        color: ColorManager.darkGray, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you want to ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                      model.isBlocked!
                          ? Text(
                              "UnBlock this user?",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                          : Text(
                              "Block this user?",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                    ],
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
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          var cubit = AdminCubit.getCubit(context);
                          bool? status = model.isBlocked;
                          if (status!) {
                            cubit.blockUser(
                                userType: userType,
                                isBlocked: false,
                                index: index);
                          } else {
                            cubit.blockUser(
                                userType: userType,
                                isBlocked: true,
                                index: index);
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ok",
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
                                MaterialStatePropertyAll(Colors.blue)),
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

  Future showDoctorInfoDialog(Doctor model, context) => showDialog(
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
                    "Doctor Information",
                    style: getBoldStyle(
                        color: ColorManager.darkGray, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Name : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.name}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.email}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.phone}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Department : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.department}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gender : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.gender}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date of birth : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.dateOfBirth}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Doctor Rate : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.rate}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Status : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      model.isBlocked!
                          ? Text(
                              "Blocked",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                          : Text(
                              "Unblocked",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                    ],
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
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
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

  Future showStudentInfoDialog(Student model, context) => showDialog(
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
                    "Doctor Information",
                    style: getBoldStyle(
                        color: ColorManager.darkGray, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Name : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.name}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.email}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.phone}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Department : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.department}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gender : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.gender}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date of birth : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      Text(
                        "${model.dateOfBirth}",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Status : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
                      ),
                      model.isBlocked!
                          ? Text(
                              "Blocked",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                          : Text(
                              "Unblocked",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 14),
                            )
                    ],
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
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
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
