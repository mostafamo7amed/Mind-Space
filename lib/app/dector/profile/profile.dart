import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Column(
        children: [
          SizedBox(
            height: 130,
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
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 15),
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
                          child: Text(
                            "Ali mohamed ali ali mohamed ali ali mohamed ali ali mohamed ali",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                InkWell(
                  child: Card(
                      margin: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 3,
                      child: Row(children: [
                        Padding(
                          padding:const EdgeInsets.all(20.0),
                          child: Text("Personal Information",
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
                    //navigateTo(context, UserManagement());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Card(
                      margin: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 3,
                      child: Row(children: [
                        Padding(
                          padding:const EdgeInsets.all(20.0),
                          child: Text("Edit Account",
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
                    //navigateTo(context, AppointmentManagement());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
