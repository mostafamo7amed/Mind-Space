import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_admin_view.dart';
import 'package:mind_space/app/doctor/home/home_doctor_view.dart';
import 'package:mind_space/app/login/login_cubit/states.dart';

import '../../../shared/components/component.dart';
import '../../student/home/home_student_view.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SocialInitState());

  static LoginCubit getCubit(context) => BlocProvider.of(context);
  userLogin({
    required String email,
    required String password,
    required context,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //findUserType(value.user!.uid, context);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState());
      toast(message: error.toString(), data: ToastStates.error);
    });
  }

  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginPasswordState());
  }


  findUserType(String UID,context){
    if(FirebaseFirestore.instance.collection('admin').doc(UID).id==UID){
      navigateAndFinish(context, HomeAdminView());
    }else if(FirebaseFirestore.instance.collection('doctor').doc(UID).id==UID){
      navigateAndFinish(context, HomeDoctorView());
    }else if(FirebaseFirestore.instance.collection('student').doc(UID).id==UID){
      navigateAndFinish(context, HomeStudentView());
    }
    emit(LoginNavigateState());
    toast(message:UID.toString(), data: ToastStates.success);

  }

}
