import 'package:flutter/material.dart';
import 'package:mind_space/app/dector/group%20_session/view_group_session.dart';
import 'package:mind_space/shared/components/component.dart';
import '../../../styles/icons_broken.dart';
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
        onPressed: () {},
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
          navigateTo(context, const ViewGroupSession());
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
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
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
}
