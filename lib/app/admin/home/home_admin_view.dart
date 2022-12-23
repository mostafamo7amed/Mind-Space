import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/admin/appointment_management/appointment_management.dart';
import 'package:mind_space/app/admin/user_management/user_management.dart';
import 'package:mind_space/shared/components/component.dart';
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
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage(ImageAssets.shutdown),
              size: 25,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(children: [
          SvgPicture.asset(
            ImageAssets.wave,
            height: 200,
            alignment: Alignment.topCenter,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InkWell(
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Row(children: [
                        Padding(
                          padding:const EdgeInsets.all(20.0),
                          child: Text("User management",
                          style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18) ,),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(IconBroken.Arrow___Right_2),
                        ),
                      ],)
                    ),
                    onTap: () {
                      navigateTo(context, UserManagement());
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Card(
                        margin: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        child: Row(children: [
                          Padding(
                            padding:const EdgeInsets.all(20.0),
                            child: Text("Appointment management",
                              style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18) ,),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconBroken.Arrow___Right_2),
                          ),
                        ],)
                    ),
                    onTap: () {
                      navigateTo(context, AppointmentManagement());
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
