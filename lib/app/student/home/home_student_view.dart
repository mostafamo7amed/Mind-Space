import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/student/appointment/group/group_appointment.dart';
import 'package:mind_space/app/student/appointment/individual/individual_appointment.dart';
import '../../../shared/components/component.dart';
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
    return BlocProvider(
      create: (context) => StudentCubit(),
      child: BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.background,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
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
            body: Column(
              children: [
                Container(
                  height: 130,
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
                            child: const CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                ImageAssets.photo,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Expanded(
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
                                        color: ColorManager.darkPrimary,
                                        fontSize: 20),
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
                                        color: ColorManager.darkPrimary,
                                        fontSize: 20),
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
                                  builder: (context) =>
                                      bottomSheetBuilder(context),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

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
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              height: 4,
            ),
          ),
        ),
        Text(
          'Choose an Option',
          style:
              getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        SizedBox(height: 10,),
        InkWell(
          child: Card(
              margin: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(IconBroken.Home,size: 30,color: ColorManager.gray,),
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
                    child: Icon(IconBroken.Arrow___Right_2,color: ColorManager.gray,),
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
                    child: Icon(IconBroken.Video,size: 35,color: ColorManager.gray,),
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
                    child: Icon(IconBroken.Arrow___Right_2,color: ColorManager.gray,),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
            navigateTo(context, IndividualAppointment('Online'));
          },
        ),
        SizedBox(height: 15,),
      ],
    ),
  );
}
