import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mind_space/app/student/appointment/group/group_appointment.dart';
import 'package:mind_space/app/student/appointment/individual/individual_appointment.dart';
import 'package:url_launcher/url_launcher.dart';
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
          return DefaultTabController(
            length: 2,
            child: Scaffold(
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
                        ]),
                      ),
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
                        Tab(text: "Sessions"),
                        Tab(text: "My Sessions"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                          children: [allSession(context), bookedAppListView()]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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

  Widget bookedAppListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return bookedItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 3),
        ],
      ),
    );
  }
  Widget bookedItemBuilder(context) {
    return InkWell(
      onTap: () {
        showAppointmentDialog(context);
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
                          "22 Jun 2023",
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

  Future showAppointmentDialog(context) => showDialog(
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
                  ImageIcon(AssetImage(ImageAssets.point),
                    size: 12,
                    color: ColorManager.error,
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
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Doctor : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "Dr.Mohamed",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "20 Jun 2023",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Time : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "9:00 AM",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Link : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Linkify(
                          onOpen: _onOpen,
                          style: getSemiBoldStyle(color: ColorManager.blue,fontSize: 14),
                          text: "https://galaxystore.samsung.com/games?langCd=ar",
                        ),
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
                      //ToDo block user
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




  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

}
