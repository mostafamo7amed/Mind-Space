import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/create_account/create_account_cubit/states.dart';
import 'package:mind_space/app/models/doctor.dart';
import 'package:mind_space/app/models/student.dart';

class CreateCubit extends Cubit<CreateStates>{
  CreateCubit() : super(CreateUserIntiStates());

  static CreateCubit getCubit(context) => BlocProvider.of(context);

  void createUser({
    required String userType,
    required String email,
    required String name,
    required String phone,
    required String id,
    required String department,
    required String image,
    required String dateOfBirth,
    required String gender,
    required bool isBlocked,
    double? rate,
  }) {
    if(userType == 'Doctor'){
      Doctor doctorModel =Doctor(id, name, dateOfBirth, department, gender, email, phone, image, isBlocked, rate);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(id)
          .set(doctorModel.toMap()!)
          .then((value) {
        emit(CreateUserSuccessState(id));
      }).catchError((e) {
        emit(CreateUserErrorState());
      });
    }else{
      Student studentModel =Student(id, name, dateOfBirth, department, gender, email, phone, image, isBlocked);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(id)
          .set(studentModel.toMap()!)
          .then((value) {
        emit(CreateUserSuccessState(id));
      }).catchError((e) {
        emit(CreateUserErrorState());
      });
    }
  }
}