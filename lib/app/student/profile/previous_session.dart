import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class PreviousSession extends StatelessWidget {
  const PreviousSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('Previous Session'),),
        backgroundColor: ColorManager.background,
        body: Column(
          children: [
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
                  Tab(text: "Online"),
                  Tab(text: "At clinic"),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TabBarView(
                    children: [onlineAppListView(), offlineAppListView()]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget onlineAppListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return onlineItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget offlineAppListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return offlineItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget onlineItemBuilder(context) {
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

  Widget offlineItemBuilder(context) {
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
              Text(
                "22 Jun 2023",
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
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Doctor report : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Review Doctor : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                      RatingBar.builder(
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (value) {
                          //todo change rating double
                        },
                        minRating: 3,
                        allowHalfRating: true,
                        updateOnDrag: true,
                        unratedColor: Colors.grey,
                        glowColor: Colors.orange,
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
}
