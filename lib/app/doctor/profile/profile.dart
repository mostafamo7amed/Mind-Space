import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/app/doctor/profile/edit_profile.dart';
import 'package:mind_space/app/doctor/profile/view_personal_info.dart';
import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = DoctorCubit.getCubit(context);

        return Scaffold(
          backgroundColor: ColorManager.background,
          body: ConditionalBuilder(
            condition: cubit.doctorModel != null,
            builder: (context) {
              return Column(
                children: [
                  SizedBox(
                    height: 130,
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 38,
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(cubit.doctorModel!.image!),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    "${cubit.doctorModel!.name}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: getSemiBoldStyle(
                                        color: ColorManager.darkGray, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        InkWell(
                          child: Card(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 3,
                              child: Row(children: [
                                Padding(
                                  padding:const EdgeInsets.all(20.0),
                                  child: Text("Personal Information",
                                    style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18) ,),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(IconBroken.Arrow___Right_2),
                                ),
                              ],)
                          ),
                          onTap: () {
                            navigateTo(context, ViewDoctorInfo());
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Card(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 3,
                              child: Row(children: [
                                Padding(
                                  padding:const EdgeInsets.all(20.0),
                                  child: Text("Edit Account",
                                    style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18) ,),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(IconBroken.Arrow___Right_2),
                                ),
                              ],)
                          ),
                          onTap: () {
                            navigateTo(context, EditDoctorProfile());
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          margin: const EdgeInsets.all(5),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          child: Row(children: [
                            Padding(
                              padding:const EdgeInsets.all(20.0),
                              child: Text("Feedbacks",
                                style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18) ,),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: RatingBar.builder(
                                itemSize: 25,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                initialRating: cubit.doctorModel!.rate!,
                                onRatingUpdate: (value) {},
                                minRating: 3,
                                ignoreGestures: true,
                                allowHalfRating: true,
                                updateOnDrag: true,
                                unratedColor: Colors.grey,
                                glowColor: Colors.orange,
                              ),
                            ),
                          ],
                          ),
                        ),
                        /*SizedBox(
                          height: 100,
                          width: 200,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 1,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ImageIcon(
                                        const AssetImage(ImageAssets.message),
                                        color: ColorManager.error,
                                        size: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("We Ready to help",
                                        style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 14),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              );
            },
            fallback: (context) => SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: ColorManager.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
