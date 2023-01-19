import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mind_space/app/doctor/group%20_session/add_group_session.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/shared/components/component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../styles/icons_broken.dart';
import '../../models/group_session.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

class GroupSession extends StatelessWidget {
  GroupSession({Key? key}) : super(key: key);
  var linkController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DoctorCubit.getCubit(context).getGroupSession();
    return BlocConsumer<DoctorCubit, DoctorStates>(
      listener: (context, state) {
        if(state is DeleteGroupSessionSuccessState || state is EditGroupSessionSuccessState){
          DoctorCubit.getCubit(context).getGroupSession();
        }
      },
      builder: (context, state) {
        var cubit = DoctorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          body: ConditionalBuilder(
            condition: cubit.groupSessionList.isNotEmpty,
            builder: (context) => groupSessionListView(context),
            fallback: (context) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(IconBroken.Hide,color:ColorManager.gray,size: 40 ,),
                  SizedBox(height: 10,),
                  Text('There is no group session yet',style: getSemiBoldStyle(color: ColorManager.gray,fontSize: 16),),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              navigateTo(context, AddGroupSession());
            },
          ),
        );
      },
    );
  }

  Widget groupSessionListView(context) {
    var cubit = DoctorCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return groupSessionItemBuilder(
                    cubit.groupSessionList[index], context, index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
              itemCount: cubit.groupSessionList.length),
        ],
      ),
    );
  }

  Widget groupSessionItemBuilder(GroupSessionModel model, context, index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: InkWell(
        onTap: () {
          showGroupSessionDialog(model, context, index);
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
                          "${model.date}",
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
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${model.title}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 10),
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

  Future showGroupSessionDialog(GroupSessionModel model, context, index) =>
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        ImageIcon(
                          AssetImage(ImageAssets.point),
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
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Title : ",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                "${model.title}",
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
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
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
                                "${model.status}",
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
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
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
                                "${model.date}",
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
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Time : ",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                "${model.time}",
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
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
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
                                style: getSemiBoldStyle(
                                    color: ColorManager.blue, fontSize: 14),
                                text: "${model.link}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
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
                              '${model.description}',
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
                            Navigator.pop(context);
                            showEditGroupDialog(model, context, index);
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
                            Navigator.pop(context);
                            showDeleteGroupDialog(model,context,index);
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

  Future showEditGroupDialog(GroupSessionModel model, context, index) {
    var cubit  = DoctorCubit.getCubit(context);
    linkController.text = cubit.groupSessionList[index].link!;
    int x = cubit.groupSessionList[index].status == 'Opened'? 1:2;
    cubit.changeGroupSessionStatus(x);
    return showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<DoctorCubit,DoctorStates>(
          listener: (context, state) {},
          builder: (context, state) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          ImageIcon(
                            AssetImage(ImageAssets.point),
                            size: 12,
                            color: ColorManager.error,
                          ),
                        ],
                      ),
                      Text(
                        "Edit Group Information",
                        style: getBoldStyle(
                            color: ColorManager.darkGray, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: linkController,
                              maxLines: null,
                              style: getRegularStyle(
                                  color: ColorManager.black, fontSize: 16),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                hintText: 'Enter group link',
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter link for group session';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Status ',
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                          Radio(
                              activeColor: ColorManager.primary,
                              focusColor: ColorManager.primary,
                              value: 1,
                              groupValue: cubit.status,
                              onChanged: (value) {
                                cubit.changeGroupSessionStatus(value!);
                              }),
                          Text(
                            "Opened",
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                          Radio(
                              activeColor: ColorManager.primary,
                              focusColor: ColorManager.primary,
                              value: 2,
                              groupValue: cubit.status,
                              onChanged: (value) {
                                cubit.changeGroupSessionStatus(value!);
                              }),
                          Text(
                            "Closed",
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                        ],
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
                              if (formKey.currentState!.validate()) {
                                String status =
                                cubit.status== 1 ? 'Opened' : 'Closed';
                                DoctorCubit.getCubit(context)
                                    .EditGroupSessionLinkOrStatus(
                                    link: linkController.text,
                                    index: index,
                                    status: status);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Save",
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
              ),
            ),
          ),
        );
      },);
  }

  Future showDeleteGroupDialog(GroupSessionModel model, context, index) =>
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        ImageIcon(
                          AssetImage(ImageAssets.point),
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
                   SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('Do you want to delete this Session?',
                          style: getRegularStyle(color: ColorManager.black,fontSize: 15),),
                        )
                      ],
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
                              MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            DoctorCubit.getCubit(context).DeleteGroupSession(index: index);
                            Navigator.pop(context);
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
            ),
          );
        },
      );

}
