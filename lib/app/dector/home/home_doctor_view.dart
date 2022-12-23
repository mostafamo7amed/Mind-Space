import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/dector/home/home_cubit/cubit.dart';
import 'package:mind_space/app/dector/home/home_cubit/states.dart';
import 'package:mind_space/app/resources/color_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';

class HomeDoctorView extends StatelessWidget {
  const HomeDoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit(),
      child: BlocConsumer<DoctorCubit, DoctorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DoctorCubit.getCubit(context);
          return Scaffold(
            backgroundColor: ColorManager.background,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    AssetImage(ImageAssets.shutdown),
                    size: 25,
                  ),
                ),
              ],
              elevation: 0.0,
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time_outlined),
                    label: 'Appointment'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check_circle_outlined),
                    label: 'Accepted'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), label: 'Group session'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}