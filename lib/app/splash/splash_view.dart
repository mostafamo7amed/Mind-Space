import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_space/app/doctor/home/home_doctor_view.dart';
import 'package:mind_space/app/resources/assets_manager.dart';
import 'package:mind_space/shared/components/component.dart';
import 'package:mind_space/shared/network/local/cache_helper.dart';
import '../admin/home/home_admin_view.dart';
import '../login/login_view.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../student/home/home_student_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }

  _splashDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    if(CacheHelper.getData(key: 'uid')!=null){
      uid = CacheHelper.getData(key: 'uid');
    }
    if(uid.isNotEmpty){
      findUserType(uid, context);
    }else{
      navigateAndFinish(context, LoginView());
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  findUserType(String UID,context){
    if(FirebaseFirestore.instance.collection('admin').doc(UID).id==UID){
      navigateAndFinish(context, HomeAdminView());
    }else if(FirebaseFirestore.instance.collection('doctor').doc(UID).id==UID){
      navigateAndFinish(context, HomeDoctorView());
    }else if(FirebaseFirestore.instance.collection('student').doc(UID).id==UID){
      navigateAndFinish(context, HomeStudentView());
    }
  }
}
