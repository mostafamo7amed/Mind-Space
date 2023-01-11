import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/admin/appointment_management/appointment_management.dart';
import 'package:mind_space/app/admin/user_management/user_management.dart';
import 'package:mind_space/app/login/login_view.dart';
import 'package:mind_space/shared/components/component.dart';
import 'package:mind_space/shared/network/local/cache_helper.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class HomeAdminView extends StatelessWidget {
  const HomeAdminView({Key? key}) : super(key: key);

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
      body: Column(children: [
        SizedBox(
          height: 150,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 35),
                  child: Row(
                    children: [
                      CircleAvatar(
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
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: getBoldStyle(color: ColorManager.white, fontSize: 30),
                            ),
                            Text(
                              "examole@example.org",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  child: Card(
                      margin: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "User management",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 18),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconBroken.Arrow___Right_2),
                          ),
                        ],
                      )),
                  onTap: () {
                    navigateTo(context, UserManagement());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Card(
                      margin: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Appointment management",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 18),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconBroken.Arrow___Right_2),
                          ),
                        ],
                      )),
                  onTap: () {
                    navigateTo(context, AppointmentManagement());
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
