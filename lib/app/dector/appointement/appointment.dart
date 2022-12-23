import 'package:flutter/material.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class Appointment extends StatelessWidget {
  Appointment({Key? key}) : super(key: key);

  List<Widget> taps = [
    Container(
      color: Colors.cyan,
    ),
    Container(
      color: Colors.red,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorManager.background,
        body: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14),
                child: Row(children: [
                  Text("Welcome",
                      style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSizeManager.s24)),
                  const Spacer(),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        ImageAssets.photo,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
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
                child: TabBarView(children: [
                  onlineAppListView(),
                  offlineAppListView()
                ]),
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
                return onlineItemBuilder();
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
                return offlineItemBuilder();
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget onlineItemBuilder() {
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
                    Icon(IconBroken.Arrow___Right_2,color: ColorManager.white,),
                  ],
                ),
              )
            ],
          )),
    );
  }
  Widget offlineItemBuilder() {
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
                    Icon(IconBroken.Arrow___Right_2,color: ColorManager.white,),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
