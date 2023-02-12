import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/student/appointment/group/group_appointment.dart';
import 'package:mind_space/app/student/appointment/individual/individual_appointment.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../styles/icons_broken.dart';
import '../../login/login_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../profile/profile_view.dart';
import 'home_student_cubit/cubit.dart';
import 'home_student_cubit/states.dart';

class HomeStudentView extends StatelessWidget {
  const HomeStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentCubit.getCubit(context).getStudent(CacheHelper.getData(key: 'uid'));
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {
        if (state is GetStudentSuccessState) {
          if(StudentCubit.getCubit(context).studentModel!.isBlocked!){
            showAlertDialog(context);
          }else{
            StudentCubit.getCubit(context).GetAllGroupSession();
          }
        }
        if (state is GetAllGroupSessionSuccessState) {
          print(
              '${StudentCubit.getCubit(context).allGroupSessionBookingList.isNotEmpty}');
        }
      },
      builder: (context, state) {
        var cubit = StudentCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: ColorManager.background,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    CacheHelper.removeData(key: 'uid');
                    uid = '';
                    print(CacheHelper.getData(key: 'uid'));
                    navigateAndFinish(context, LoginView());
                  },
                  icon: const ImageIcon(
                    AssetImage(ImageAssets.shutdown),
                    size: 25,
                  ),
                ),
              ],
              elevation: 0.0,
            ),
            body: ConditionalBuilder(
              condition: cubit.studentModel != null,
              builder: (context) => Column(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, right: 14, bottom: 15),
                        child: Row(children: [
                          Text("Welcome",
                              style: getBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSizeManager.s24)),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              navigateTo(context, StudentProfile());
                            },
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(cubit.studentModel!.image!),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: allSession(context),
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

  Widget allSession(context) => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'What Session You Want?',
                style: getSemiBoldStyle(
                    color: ColorManager.darkPrimary, fontSize: 24),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        child: Center(
                            child: Text(
                          'Group\nSession',
                          style: getSemiBoldStyle(
                              color: ColorManager.darkPrimary, fontSize: 20),
                        )),
                      ),
                    ),
                    onTap: () {
                      navigateTo(context, GroupAppointment());
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        child: Center(
                            child: Text(
                          'Individual\nSession',
                          style: getSemiBoldStyle(
                              color: ColorManager.darkPrimary, fontSize: 20),
                        )),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: ColorManager.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        context: context,
                        builder: (context) => bottomSheetBuilder(context),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      );

  Widget bottomSheetBuilder(context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                      color: ColorManager.gray.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  height: 4,
                ),
              ),
            ),
            Text(
              'Choose an Option',
              style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Card(
                  margin: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Home,
                          size: 30,
                          color: ColorManager.gray,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "At clinic",
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 18),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Arrow___Right_2,
                          color: ColorManager.gray,
                        ),
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, IndividualAppointment('At clinic'));
              },
            ),
            InkWell(
              child: Card(
                  margin: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Video,
                          size: 35,
                          color: ColorManager.gray,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Online",
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 18),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          IconBroken.Arrow___Right_2,
                          color: ColorManager.gray,
                        ),
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.pop(context);
                navigateTo(context, IndividualAppointment('Online'));
              },
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      );

  Future showAlertDialog(context) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      String mess ="You cannot currently use the application\n For inquiries contact";
      String mess3 ='admin@mindspace.edu.sa';
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
              Text(
                "Alert",
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
                    '$mess \n $mess3',
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 12),
                  ),
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
                        MaterialStatePropertyAll(ColorManager.primary)),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      CacheHelper.removeData(key: 'uid');
                      uid = '';
                      print(CacheHelper.getData(key: 'uid'));
                      navigateAndFinish(context, LoginView());
                    },
                    child: Text(
                      "Logout",
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
