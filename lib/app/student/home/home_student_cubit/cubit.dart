import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/models/student.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';

import '../../../models/appointment.dart';
import '../../../models/doctor.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentInitState());

  static StudentCubit getCubit(context) => BlocProvider.of(context);

  Student? studentModel;
  void getStudent(String uid) {
    emit(GetStudentLoadingState());
    FirebaseFirestore.instance
        .collection('Student')
        .doc(uid)
        .get()
        .then((value) {
      studentModel = Student.fromMap(value.data()!);
      print(studentModel!.email);
      emit(GetStudentSuccessState());
    }).catchError((e) {
      emit(GetStudentErrorState());
    });
  }

  List<Doctor> doctorModelList =[];
  void getAllDoctors() {
    doctorModelList =[];
    emit(GetDoctorLoadingState());
    FirebaseFirestore.instance.collection('Doctor').get().then((value) {
      for (var element in value.docs) {
        doctorModelList.add(Doctor.fromMap(element.data()));
      }
      emit(GetDoctorSuccessState());
    }).catchError((e) {
      emit(GetDoctorErrorState());
    });
  }

  makeAppointment({
    required String type,
    required String accountType,
    required String doctorId,
    required String date,
    required String time,
    required String studentNickname,
  }) async {
    emit(MakeAppointmentLoadingState());
    String appointmentId = await generateRandomString(25);
    AppointmentModel appointmentModel = AppointmentModel(
        appointmentId, studentModel!.id, accountType, date, time, '', type, doctorId,studentNickname);
    FirebaseFirestore.instance
        .collection('Individual Session')
        .doc(appointmentId)
        .set(appointmentModel.toMap()!)
        .then((value) {
      emit(MakeAppointmentSuccessState());
    }).catchError((e) {
      emit(MakeAppointmentErrorState());
    });
  }

  String individualDate = '';
  getAppointmentDate(String date){
    individualDate = date;
    emit(GetAppointmentDateState());
  }

  String individualTime = '';
  int? changeColor;
  getAppointmentTime(String time,int index){
    individualTime = time;
    changeColor = index;
    emit(GetAppointmentTimeState());
  }


  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
