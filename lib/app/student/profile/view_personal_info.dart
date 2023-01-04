import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class ViewStudentInfo extends StatelessWidget {
  const ViewStudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(title: Text('Personal Information'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        child: const CircleAvatar(
                          radius: 43,
                          backgroundImage: AssetImage(
                            ImageAssets.photo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                child: Column(
                  children: [
                    Text("Ali Mohamed",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18)),
                    SizedBox(height: 10,),
                    Card(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "example4353@example.org",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSemiBoldStyle(
                                          color: ColorManager.darkGray, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Card(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "+966123456788",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSemiBoldStyle(
                                          color: ColorManager.darkGray, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Card(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Department ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Computer Science",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSemiBoldStyle(
                                          color: ColorManager.darkGray, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Card(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date of birth ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "20 Nov 1988",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSemiBoldStyle(
                                          color: ColorManager.darkGray, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Card(
                        margin: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Male",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSemiBoldStyle(
                                          color: ColorManager.darkGray, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
