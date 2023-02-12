import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_space/app/models/student.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';
import '../../../models/appointment.dart';
import '../../../models/date.dart';
import '../../../models/doctor.dart';
import '../../../models/group_session.dart';

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

  List<Doctor> doctorModelList = [];
  void getAllDoctors() {
    doctorModelList = [];
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
    required String doctorName,
  }) async {
    emit(MakeAppointmentLoadingState());
    String appointmentId = await generateRandomString(25);
    AppointmentModel appointmentModel = AppointmentModel(
        appointmentId,
        studentModel!.id,
        accountType,
        date,
        time,
        '',
        type,
        doctorId,
        studentNickname,
        'Processing',
        '',
        false,
        doctorName,
    );
    FirebaseFirestore.instance
        .collection('Appointment')
        .doc(appointmentId)
        .set(appointmentModel.toMap()!)
        .then((value) {
          bookingDates(appointmentId: appointmentId, doctorId: doctorId, date: date, time: time);
      emit(MakeAppointmentSuccessState());
    }).catchError((e) {
      emit(MakeAppointmentErrorState());
    });
  }
   void bookingDates({
     required String appointmentId,
     required String doctorId,
     required String date,
     required String time,
}){
    BookingDate bookingDate = BookingDate(date, time);
     FirebaseFirestore.instance
         .collection('Booking dates')
         .doc(doctorId)
         .collection('Dates')
         .doc(appointmentId).set(bookingDate.toMap()!).then((value) {
       emit(BookingDateSuccessState());
     }).catchError((e){
       emit(BookingDateErrorState());
     });
   }
   List <BookingDate> doctorDares =[];
  void getBookingDates({
    required String doctorId,
  }){
    doctorDares =[];
    FirebaseFirestore.instance
        .collection('Booking dates')
        .doc(doctorId)
        .collection('Dates')
        .get().then((value) {
      for (var element in value.docs) {
        doctorDares.add(BookingDate.fromMap(element.data()));
      }
      emit(GetBookingDateSuccessState());
    }).catchError((e){
      emit(GetBookingDateErrorState());
    });
  }

  String dateExist = 'no';
  void searchForDate(String date ,String time){
    dateExist = 'no';
    doctorDares.forEach((element) {
      if(element.time == time && element.date==date){
        dateExist = 'yes';
      }
    });
    emit(FindBookingDateState());
  }




  String individualDate = '';
  getAppointmentDate(String date) {
    individualDate = date;
    emit(GetAppointmentDateState());
  }

  String individualTime = '';
  int? changeColor;
  getAppointmentTime(String time, int index) {
    individualTime = time;
    changeColor = index;
    emit(GetAppointmentTimeState());
  }

  List<GroupSessionModel> allGroupSessionList = [];
  List<GroupSessionModel> allGroupSessionBookingList = [];
  GetAllGroupSession() {
    allGroupSessionList = [];
    allGroupSessionBookingList = [];
    emit(GetAllGroupSessionLoadingState());
    FirebaseFirestore.instance.collection('Session').get().then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('Session')
            .doc(element.id)
            .collection('Subscription')
            .get()
            .then((value) {
          for (var elements in value.docs) {
            if (elements.id == studentModel!.id) {
              allGroupSessionBookingList
                  .add(GroupSessionModel.fromMap(element.data()));
            }
          }
          emit(GetAllGroupSessionSuccessState());
        });
        allGroupSessionList.add(GroupSessionModel.fromMap(element.data()));
      }
      emit(GetAllGroupSessionSuccessState());
    }).catchError((e) {
      emit(GetAllGroupSessionErrorState());
    });
  }

  bookGroupSession({required int index}) {
    FirebaseFirestore.instance
        .collection('Session')
        .doc(allGroupSessionList[index].groupId)
        .collection('Subscription')
        .doc(studentModel!.id)
        .set({
      'studentId': studentModel!.id,
      'studentEmail': studentModel!.email,
    }).then((value) {
      emit(BookGroupSessionSuccessState());
    }).catchError((e) {
      emit(BookGroupSessionErrorState());
    });
  }

  UnBookGroupSession({required int index}) {
    FirebaseFirestore.instance
        .collection('Session')
        .doc(allGroupSessionBookingList[index].groupId)
        .collection('Subscription')
        .doc(studentModel!.id)
        .delete()
        .then((value) {
      emit(UnBookGroupSessionSuccessState());
    }).catchError((e) {
      emit(UnBookGroupSessionErrorState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(PikImageSuccessState());
    } else {
      print('No image selected');
      emit(PikImageErrorState());
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
        emit(EditImageSuccessState());
      }).catchError((e) {
        emit(EditImageErrorState());
      });
    }).catchError((error) {
      emit(EditImageErrorState());
      print(error.toString());
    });
  }

  void updateStudentProfile({
    required String name,
    required String phone,
    required String department,
    required String image,
    required String dateOfBirth,
    required String gender,
  }) {
    emit(UpdateStudentLoadingState());
    Student student = Student(studentModel!.id, name, dateOfBirth, department,
        gender, studentModel!.email, phone, image, studentModel!.isBlocked);
    FirebaseFirestore.instance
        .collection('Student')
        .doc(studentModel!.id)
        .update(student.toMap()!)
        .then((value) {
      emit(UpdateStudentSuccessState());
    }).catchError((e) {
      emit(UpdateStudentErrorState());
    });
  }

  List<AppointmentModel> onlineAppointmentList = [];
  List<AppointmentModel> offlineAppointmentList = [];
  void getAllOnlinePreviousAppointment() {
    onlineAppointmentList = [];
    emit(GetOfflineAppointmentLoadingState());
    FirebaseFirestore.instance
        .collection('Appointment')
        .where('studentId', isEqualTo: studentModel!.id)
        .where('type', isEqualTo: 'Online')
        .get()
        .then((value) {
      for (var element in value.docs) {
        onlineAppointmentList.add(AppointmentModel.fromMap(element.data()));
      }
      emit(GetOfflineAppointmentSuccessState());
    }).catchError((e) {
      emit(GetOfflineAppointmentErrorState());
    });
  }

  void getAllOfflinePreviousAppointment() {
    offlineAppointmentList = [];
    emit(GetOnlineAppointmentLoadingState());
    FirebaseFirestore.instance
        .collection('Appointment')
        .where('studentId', isEqualTo: studentModel!.id)
        .where('type', isEqualTo: 'At clinic')
        .get()
        .then((value) {
      for (var element in value.docs) {
        offlineAppointmentList.add(AppointmentModel.fromMap(element.data()));
      }
      emit(GetOnlineAppointmentSuccessState());
    }).catchError((e) {
      emit(GetOnlineAppointmentErrorState());
    });
  }

  Doctor? doctorModelForRate;
  void getRateDoctor(String doctorId, double rate,int index,String appointmentType) {
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(doctorId)
        .get()
        .then((value) {
      doctorModelForRate = Doctor.fromMap(value.data()!);
      print(doctorModelForRate!.email!);
      changeAppointmentRateStatus(appointmentType: appointmentType, index: index, rate: rate);
      emit(GetDoctorForRateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDoctorForRateErrorState());
    });
  }
  double? rate;
  changeRate(double value){
    rate =value;
    emit(GetRateState());
  }
  void Rate(double rate) {
    double newRate =doctorModelForRate!.rate!+rate;
    Doctor doctor = Doctor(
      doctorModelForRate!.id,
      doctorModelForRate!.name,
      doctorModelForRate!.dateOfBirth,
      doctorModelForRate!.department,
      doctorModelForRate!.gender,
      doctorModelForRate!.email,
      doctorModelForRate!.phone,
      doctorModelForRate!.image,
      doctorModelForRate!.isBlocked,
      newRate,
    );
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(doctorModelForRate!.id)
        .update(doctor.toMap()!)
        .then((value) {
      emit(RateSuccessState());
    }).catchError((e) {
      emit(RateErrorState());
    });

  }
  void changeAppointmentRateStatus({
    required String appointmentType,
    required index,
    required double rate,
  }) {
    if (appointmentType == 'Online') {
      AppointmentModel appointmentModel = AppointmentModel(
        onlineAppointmentList[index].appointmentId,
        onlineAppointmentList[index].studentId,
        onlineAppointmentList[index].accountType,
        onlineAppointmentList[index].date,
        onlineAppointmentList[index].time,
        onlineAppointmentList[index].link,
        onlineAppointmentList[index].type,
        onlineAppointmentList[index].doctorId,
        onlineAppointmentList[index].studentNickname,
        onlineAppointmentList[index].status,
        onlineAppointmentList[index].doctorReport,
        true,
        onlineAppointmentList[index].doctorName
      );
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(onlineAppointmentList[index].appointmentId)
          .update(appointmentModel.toMap()!)
          .then((value) {
        emit(ChangeRateStatusSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(ChangeRateStatusErrorState());
      });
    } else {
      AppointmentModel appointmentModel = AppointmentModel(
        offlineAppointmentList[index].appointmentId,
        offlineAppointmentList[index].studentId,
        offlineAppointmentList[index].accountType,
        offlineAppointmentList[index].date,
        offlineAppointmentList[index].time,
        offlineAppointmentList[index].link,
        offlineAppointmentList[index].type,
        offlineAppointmentList[index].doctorId,
        offlineAppointmentList[index].studentNickname,
        offlineAppointmentList[index].status,
        offlineAppointmentList[index].doctorReport,
        true,
        offlineAppointmentList[index].doctorName,
      );
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(offlineAppointmentList[index].appointmentId)
          .update(appointmentModel.toMap()!)
          .then((value) {
        emit(ChangeRateStatusSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(ChangeRateStatusErrorState());
      });
    }
  }

  int gender =1;
  void changeGender(int value){
    gender = value;
    emit(ChangeGenderState());
  }
  void deletePhoto(){
    imageUri = 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg';
    emit(DeletePhotoState());
  }
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
