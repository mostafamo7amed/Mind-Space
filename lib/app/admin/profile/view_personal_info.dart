import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/admin/home/home_cubit/cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../home/home_cubit/states.dart';

class ViewAdminInfo extends StatelessWidget {
  const ViewAdminInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
     listener: (context, state) {

     },
      builder: (context, state) {
       var cubit = AdminCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          appBar: AppBar(title: Text('Personal Information'),),
          body: ConditionalBuilder(
            condition: AdminCubit.getCubit(context)
                .adminModel!=null,
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
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
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              child: const CircleAvatar(
                                radius: 43,
                                backgroundImage: AssetImage(
                                  ImageAssets.photo,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                      child: Column(
                        children: [
                          Text("System Administration",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 18)),
                          SizedBox(height: 10,),
                          Card(
                              margin: const EdgeInsets.all(2),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email ",
                                      style: getSemiBoldStyle(
                                          color: ColorManager.gray, fontSize: 16),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${cubit.adminModel!.email}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: getSemiBoldStyle(
                                                color: ColorManager.darkGray, fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
