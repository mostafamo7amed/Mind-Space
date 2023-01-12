import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../login/login_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AppointmentManagement extends StatelessWidget {
  AppointmentManagement({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                condition: false,
                builder: (context) => appointmentListView(),
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
  }

  Widget appointmentListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return appointmentItemBuilder();
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: 10
              // ToDo list count item
              ),
        ],
      ),
    );
  }

  Widget appointmentItemBuilder() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Column(
          children: [
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
                        "ali mohamed ali ali mohamed ali ali mohamed ali ali mohamed ali",
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
                      "Type : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "Online",
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
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightBlueAccent)),
                    onPressed: () {
                      //ToDo view user
                    },
                    child: Text(
                      "View",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightBlue)),
                    onPressed: () {
                      //ToDo view user
                    },
                    child: Text(
                      "Edit",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {
                      //ToDo block user
                    },
                    child: Text(
                      "Cancel",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
