import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mind_space/app/doctor/group%20_session/add_group_session.dart';
import 'package:mind_space/shared/components/component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class GroupSession extends StatelessWidget {
  const GroupSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: groupSessionListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigateTo(context, AddGroupSession());
        },
      ),
    );
  }

  Widget groupSessionListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return groupSessionItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: 10),
        ],
      ),
    );
  }

  Widget groupSessionItemBuilder(context,) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: InkWell(
        onTap: () {
          showGroupSessionDialog(context);
        },
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          "Group session",
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Title ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Depression",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15,bottom: 10),
                      child: Align(
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
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
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
  Future showGroupSessionDialog(context) => showDialog(
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
                "Group session",
                style: getBoldStyle(
                    color: ColorManager.darkGray, fontSize: 18),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Title : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "Depression",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "Closed",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Link : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                      Expanded(
                        child: Linkify(
                          onOpen: _onOpen,
                          style: getSemiBoldStyle(color: ColorManager.blue,fontSize: 14),
                          text: "https://galaxystore.samsung.com/games?langCd=ar",
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description : ",
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
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
              SizedBox(height: 10,),
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
                      "Edit",
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
                      //ToDo view user
                    },
                    child: Text(
                      "Delete",
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
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

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
