import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_space/app/create_account/create_account_cubit/states.dart';
import 'package:mind_space/app/models/doctor.dart';
import 'package:mind_space/app/models/student.dart';

class CreateCubit extends Cubit<CreateStates>{
  CreateCubit() : super(CreateUserIntiStates());

  static CreateCubit getCubit(context) => BlocProvider.of(context);



  int gender =1;
  void changeGender(int value){
    gender = value;
    emit(ChangeGenderState());
  }
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
    double? rate = 0.0,
  }) {
    emit(CreateUserLoadingState());
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


  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(CreatePikImageSuccessState());
    } else {
      print('No image selected');
      emit(CreatePikImageErrorState());
    }
  }
  String imageUri = '';
  uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        imageUri = value;
        emit(UploadImageSuccessState());
      }).catchError((e) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
      print(error.toString());
    });
  }
}