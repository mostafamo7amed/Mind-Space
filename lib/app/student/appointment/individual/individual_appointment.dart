import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mind_space/app/models/doctor.dart';
import 'package:mind_space/app/student/appointment/individual/complete_individual_appointment.dart';
import 'package:mind_space/app/student/home/home_student_cubit/cubit.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';
import 'package:mind_space/shared/components/component.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class IndividualAppointment extends StatelessWidget {
  final String appointmentType;
  IndividualAppointment(this.appointmentType,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit  = StudentCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Choose doctor'),

          ),
          body: ConditionalBuilder(
            condition: cubit.studentModel!=null&&cubit.doctorModelList.isNotEmpty,
            builder: (context) =>  Column(
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14, bottom: 15),
                      child: Row(children: [
                        Text("${appointmentType} appointment",
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSizeManager.s24)),
                        const Spacer(),
                        CircleAvatar(
                          radius: 28,
                          backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(cubit.studentModel!.image!),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Expanded(child: IndividualAppListView(context)),
              ],
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: ColorManager.primary,
              ),
            ),
          ),
        );
      },
    );
  }
  Widget IndividualAppListView(context) {
    var cubit  = StudentCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return IndividualItemBuilder(context,cubit.doctorModelList[index],index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: cubit.doctorModelList.length,
          ),
        ],
      ),
    );
  }
  Widget IndividualItemBuilder(context,Doctor model , index) {
    return InkWell(
      onTap: () {
        navigateTo(context, CompleteIndividualAppointment(appointmentType,model.id!,model.name!));
      },
      child:Padding(
        padding: EdgeInsets.only(
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
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        child: const CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage(
                            ImageAssets.photo,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          "${model.name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (value) {},
                      itemSize: 20,
                      initialRating: model.rate!,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      updateOnDrag: true,
                      unratedColor: Colors.grey,
                      glowColor: Colors.orange,
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
                        "Book",
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
