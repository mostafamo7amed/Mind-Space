import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';
import 'package:mind_space/app/models/student.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../../../models/admin.dart';
import '../../../models/doctor.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitState());

  static AdminCubit getCubit(context) => BlocProvider.of(context);



  Admin? adminModel;
  void getUser() {
    String uid = CacheHelper.getData(key: 'uid');
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('admin').doc(uid).get().then((value) {
      adminModel = Admin.fromMap(value.data()!);
      print(adminModel!.email);
      emit(GetUserSuccessState());
    }).catchError((e) {
      emit(GetUserErrorState());
    });
  }


  List<Doctor> doctorModel =[];


  void getDoctor() {
    doctorModel =[];
    emit(GetDoctorLoadingState());
    FirebaseFirestore.instance.collection('Doctor').get().then((value) {
      for (var element in value.docs) {
        doctorModel.add(Doctor.fromMap(element.data()));
      }
      emit(GetDoctorSuccessState());
    }).catchError((e) {
      emit(GetDoctorErrorState());
    });
  }

  List<Student> studentModel =[];

  void getStudent() {
    studentModel =[];
    emit(GetStudentLoadingState());
    FirebaseFirestore.instance.collection('Student').get().then((value) {
      for (var element in value.docs) {
        studentModel.add(Student.fromMap(element.data()));
      }
      emit(GetStudentSuccessState());
    }).catchError((e) {
      emit(GetStudentErrorState());
    });
  }


  void blockUser({
    required String userType,
    required bool isBlocked,
    required int index,
  }) {
    if(userType == 'Doctor'){
      Doctor updateDoctorModel =Doctor(
          doctorModel[index].id,
          doctorModel[index].name,
          doctorModel[index].dateOfBirth,
          doctorModel[index].department,
          doctorModel[index].gender,
          doctorModel[index].email,
          doctorModel[index].phone,
          doctorModel[index].image,
          isBlocked,
          doctorModel[index].rate);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(doctorModel[index].id)
          .update(updateDoctorModel.toMap()!)
          .then((value) {
            getDoctor();
        emit(ChangeUserStatusSuccessState());
      }).catchError((e) {
        emit(ChangeUserStatusErrorState());
      });
    }else{
      Student updateStudentModel = Student(
          studentModel[index].id,
          studentModel[index].name,
          studentModel[index].dateOfBirth,
          studentModel[index].department,
          studentModel[index].gender,
          studentModel[index].email,
          studentModel[index].phone,
          studentModel[index].image,
          isBlocked);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(studentModel[index].id)
          .update(updateStudentModel.toMap()!)
          .then((value) {
            getStudent();
        emit(ChangeUserStatusSuccessState());
      }).catchError((e) {
        emit(ChangeUserStatusErrorState());
      });
    }
  }

}
