import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/app/login/login_view.dart';
import 'package:mind_space/app/resources/color_manager.dart';
import 'package:mind_space/shared/components/component.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../resources/assets_manager.dart';
import '../../resources/styles_manager.dart';

class HomeDoctorView extends StatelessWidget {
  const HomeDoctorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =DoctorCubit.getCubit(context);
    cubit.getDoctor(CacheHelper.getData(key: 'uid'));
    return BlocConsumer<DoctorCubit, DoctorStates>(
      listener: (context, state) {
        if(state is GetDoctorSuccessState){
          if(cubit.doctorModel!.isBlocked!){
            showAlertDialog(context);
          }else{
            cubit.getAllOnlineAppointment();
            cubit.getAllOfflineAppointment();
          }
        }

      },
      builder: (context, state) {
        var cubit = DoctorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  CacheHelper.removeData(key: 'uid');
                  uid = '';
                  print(CacheHelper.getData(key: 'uid'));
                  navigateAndFinish(context, LoginView());
                },
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
    );
  }
  Future showAlertDialog(context) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {//
      String mess ="You cannot currently use the application\n For inquiries contact";
      String mess3 ='admin@mindspace.edu.sa';
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
              Text(
                "Alert",
                style: getBoldStyle(
                    color: ColorManager.darkGray, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$mess \n $mess3',
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 12),
                  ),
                ],
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
                        MaterialStatePropertyAll(ColorManager.primary)),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      CacheHelper.removeData(key: 'uid');
                      uid = '';
                      print(CacheHelper.getData(key: 'uid'));
                      navigateAndFinish(context, LoginView());
                    },
                    child: Text(
                      "Logout",
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
}
