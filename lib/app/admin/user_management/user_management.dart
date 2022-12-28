import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/resources/color_manager.dart';

import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';

class UserManagement extends StatelessWidget {
  UserManagement({Key? key}) : super(key: key);

  String name = 'Mohamed ali Mohamed Mohamed';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      ImageAssets.wave,
                      height: 200,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: const CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            ImageAssets.photo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  Tab(text: "Student"),
                  Tab(text: "Doctor"),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TabBarView(children: [
                  studentListView(),
                  doctorListView(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget studentListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return studentItemBuilder();
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: 10 // todo list students
          ),
        ],
      ),
    );
  }

  Widget doctorListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return doctorItemBuilder();
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget studentItemBuilder() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 140,
                  child: Text(
                    "ali mohamed ali ali mohamed ali ali mohamed ali ali mohamed ali",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                onPressed: () {
                  //ToDo block user
                },
                child: Text(
                  "Block",
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
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
              const SizedBox(width:5,),
            ],
          )),
    );
  }

  Widget doctorItemBuilder() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    "Dr. $name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 16),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red)),
                onPressed: () {
                  //ToDo block user
                },
                child: Text(
                  "Block",
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
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
              const SizedBox(width:5,),
            ],
          )),
    );
  }
}
