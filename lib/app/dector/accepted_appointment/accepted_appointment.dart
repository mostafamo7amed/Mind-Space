import 'package:flutter/material.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class AcceptedAppointment extends StatelessWidget {
  const AcceptedAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: acceptedAppListView(),
    );
  }
  Widget acceptedAppListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return acceptedAppItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }
  Widget acceptedAppItemBuilder(context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: InkWell(
        onTap: (){
          showAppointmentDialog(context);
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15),                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Online",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
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
              Text(
                "22 Jun 2023",
                style: getSemiBoldStyle(
                    color: ColorManager.darkGray, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Online",
                style: getSemiBoldStyle(
                    color: ColorManager.darkGray, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "9:00 AM",
                style: getSemiBoldStyle(
                    color: ColorManager.darkGray, fontSize: 14),
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
                      //ToDo view user
                    },
                    child: Text(
                      "Join",
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
                      //ToDo block user
                    },
                    child: Text(
                      "Cancel",
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
                      //ToDo block user
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
}
