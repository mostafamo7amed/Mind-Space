import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/app/models/appointment.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class AcceptedAppointment extends StatelessWidget {
  AcceptedAppointment({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var reportController = TextEditingController();
  var linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorStates>(
      listener: (context, state) {
        if(state is AddLinkSuccessState || state is DeleteSessionSuccessState){
          DoctorCubit.getCubit(context).getAllOfflineAppointment();
          DoctorCubit.getCubit(context).getAllOnlineAppointment();
        }
      },
      builder: (context, state) {
        var cubit =DoctorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          body: ConditionalBuilder(
            condition: cubit.acceptedAppointmentList.isNotEmpty,
            builder: (context) => acceptedAppListView(context),
            fallback: (context) => SizedBox(
              child: Center(
                child: Text(
                  'There is no accepted appointment',
                  style: getRegularStyle(
                      color: ColorManager.gray, fontSize: 18),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget acceptedAppListView(context) {
    var cubit =DoctorCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return acceptedAppItemBuilder(context,cubit.acceptedAppointmentList[index],index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: cubit.acceptedAppointmentList.length,
          ),
        ],
      ),
    );
  }
  Widget acceptedAppItemBuilder(context,AppointmentModel model ,index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: InkWell(
        onTap: (){
          showAppointmentDialog(context,model,index);
        },
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15),
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
                const SizedBox(height: 5,),
                if(model.link!='')
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0,),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Link ",
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 16),
                          ),
                          Expanded(
                            child: Linkify(
                              onOpen: _onOpen,
                              style: getSemiBoldStyle(
                                  color: ColorManager.blue, fontSize: 14),
                              text: "${model.link}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 5,),
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
                      Icon(IconBroken.Arrow___Right_2,color: ColorManager.white,),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future showAppointmentDialog(context,AppointmentModel model ,index) => showDialog(
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
              Text(
                "${model.date}",
                style: getSemiBoldStyle(
                    color: ColorManager.darkGray, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${model.type}",
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
                height: 5,
              ),
              if(model.link!='')
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0,),
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
                            style: getSemiBoldStyle(
                                color: ColorManager.blue, fontSize: 14),
                            text: "${model.link}",
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
                        MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      showFinishAppointmentDialog(model,context,index);
                    },
                    child: Text(
                      "Finish",
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
                      showCancelAppointmentDialog(model,context,index);
                    },
                    child: Text(
                      "Cancel",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if(model.type == 'Online')
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
                      showEditAppointmentDialog(model,context,index);
                    },
                    child: Text(
                      "Edit",
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


  Future showEditAppointmentDialog(AppointmentModel model, context, index) {
    var cubit  = DoctorCubit.getCubit(context);
    linkController.text = cubit.acceptedAppointmentList[index].link!;
    return showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<DoctorCubit,DoctorStates>(
          listener: (context, state) {},
          builder: (context, state) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
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
                        "Edit Appointment Information",
                        style: getBoldStyle(
                            color: ColorManager.darkGray, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: linkController,
                              maxLines: null,
                              style: getRegularStyle(
                                  color: ColorManager.black, fontSize: 16),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                hintText: 'Enter appointment link',
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter link for session';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
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
                              if (formKey.currentState!.validate()) {
                                DoctorCubit.getCubit(context)
                                    .addAppointmentLink(index, linkController.text);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Save",
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
              ),
            ),
          ),
        );
      },);
  }

  Future showCancelAppointmentDialog(AppointmentModel model, context, index) =>
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                      "Appointment session",
                      style: getBoldStyle(
                          color: ColorManager.darkGray, fontSize: 18),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('Do you want to Cancel this Session?',
                            style: getRegularStyle(color: ColorManager.black,fontSize: 15),),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
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
                            DoctorCubit.getCubit(context).DeleteAppointmentSession(index: index);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delete",
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
            ),
          );
        },
      );
  Future showFinishAppointmentDialog(AppointmentModel model, context, index) =>
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey2,
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
                        "Appointment session",
                        style: getBoldStyle(
                            color: ColorManager.darkGray, fontSize: 18),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text('Do you want to confirm finishing\n this Session?',
                              style: getRegularStyle(color: ColorManager.black,fontSize: 15),),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: reportController,
                        maxLines: null,
                        style: getRegularStyle(color: ColorManager.black,fontSize: 16),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          hintText: 'Report',
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Student report';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
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
                              if(formKey2.currentState!.validate()){
                                DoctorCubit.getCubit(context)
                                    .changeAppointmentStatus(appointmentType: model.type!, index: index,status: 'Finished',doctorReport: reportController.text);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Finish",
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
