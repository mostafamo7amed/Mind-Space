import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
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
                const SizedBox(height: 10,),
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
                    //navigateTo(context, ViewDoctorInfo());
                  },
                ),
                const SizedBox(
                  height: 5,
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
                    //navigateTo(context, EditDoctorProfile());
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Card(
                      margin: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 3,
                      child: Row(children: [
                        Padding(
                          padding:const EdgeInsets.all(20.0),
                          child: Text("Previous Session",
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
                    //navigateTo(context, ViewFeedbacks());
                  },
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ImageIcon(
                                const AssetImage(ImageAssets.message),
                                color: ColorManager.error,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("We Ready to help",
                                style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 14),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
