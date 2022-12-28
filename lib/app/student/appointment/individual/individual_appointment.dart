import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mind_space/app/student/appointment/individual/complete_individual_appointment.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose doctor'),

      ),
      body: Column(
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
          ),
          Expanded(child: IndividualAppListView()),
        ],
      ),
    );
  }
  Widget IndividualAppListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return IndividualItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10),
        ],
      ),
    );
  }
  Widget IndividualItemBuilder(context) {
    return InkWell(
      onTap: () {
        navigateTo(context, CompleteIndividualAppointment(appointmentType));
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
                          "Dr.Mohamed",
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
                      onRatingUpdate: (value) {
                        //todo change rating double
                      },
                      itemSize: 20,
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
                        "Booked",
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
