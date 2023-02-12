import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/admin/home/home_cubit/cubit.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';
import 'package:mind_space/app/models/appointment.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../login/login_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AppointmentManagement extends StatelessWidget {
  AppointmentManagement({Key? key}) : super(key: key);

  var linkController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is DeleteSessionSuccessState ||
            state is AddLinkSuccessState) {
          AdminCubit.getCubit(context).getAllAppointment();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.getCubit(context);
        return Scaffold(
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
          body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          ImageAssets.wave,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, left: 10, bottom: 20),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: defaultFormField(
                              context: context,
                              controller: searchController,
                              label: 'Search',
                              prefix: Icon(
                                Icons.search,
                                color: ColorManager.darkPrimary,
                              ),
                              onChange: (value) {
                                cubit.search(value);
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return '';
                                }
                              },
                              type: TextInputType.text,
                              onSubmit: (String text) {}),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.allAppointmentList.isNotEmpty,
                    builder: (context) => appointmentListView(context),
                    fallback: (context) => SizedBox(
                      child: Center(
                        child: Text(
                          'There is no appointment yet',
                          style: getRegularStyle(
                              color: ColorManager.gray, fontSize: 18),
                        ),
                      ),
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

  Widget appointmentListView(context) {
    var cubit = AdminCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          searchController.text.isNotEmpty &&
                  cubit.searchAppointmentList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 30,
                        color: ColorManager.primary,
                      ),
                      Text(
                        'No appointment found !',
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (searchController.text.isNotEmpty &&
                        cubit.searchAppointmentList.isNotEmpty) {
                      return appointmentItemBuilder(
                          cubit.searchAppointmentList[index],
                          context,
                          true,
                          index);
                    } else {
                      return appointmentItemBuilder(
                          cubit.allAppointmentList[index],
                          context,
                          false,
                          index);
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
                  itemCount: searchController.text.isNotEmpty
                      ? cubit.searchAppointmentList.length
                      : cubit.allAppointmentList.length,
                ),
        ],
      ),
    );
  }

  Widget appointmentItemBuilder(
      AppointmentModel model, context, bool isSearch, index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Individual Session",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
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
                        "Type : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "${model.type}",
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
                        "Date : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "${model.date}",
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
                          "${model.time}",
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
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (model.type == 'Online')
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
                          showEditAppointmentDialog(
                              model, context, index, isSearch);
                        },
                        child: Text(
                          "Edit",
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
                        showCancelAppointmentDialog(
                            model, context, index, isSearch);
                      },
                      child: Text(
                        "Cancel",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showEditAppointmentDialog(
      AppointmentModel model, context, index, bool isSearch) {
    linkController.text = model.link!;
    return showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AdminCubit, AdminStates>(
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
                              if (formKey2.currentState!.validate()) {
                                AdminCubit.getCubit(context).addAppointmentLink(
                                    index: index,
                                    link: linkController.text,
                                    isSearch: isSearch);
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
      },
    );
  }

  Future showCancelAppointmentDialog(
          AppointmentModel model, context, index, bool isSearch) =>
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Do you want to Cancel this Session?',
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 15),
                          ),
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
                            AdminCubit.getCubit(context)
                                .DeleteAppointmentSession(
                                    index: index, isSearch: isSearch);
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
}
