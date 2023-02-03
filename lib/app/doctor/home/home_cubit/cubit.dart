import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import 'package:mind_space/app/models/appointment.dart';
import 'package:mind_space/shared/components/component.dart';
import '../../../models/doctor.dart';
import '../../../models/group_session.dart';
import '../../accepted_appointment/accepted_appointment.dart';
import '../../appointement/appointment.dart';
import '../../group _session/group_session.dart';
import '../../profile/profile.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit() : super(DoctorInitState());

  static DoctorCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int status = 1;

  List<Widget> screens = [
    Appointment(),
    AcceptedAppointment(),
    GroupSession(),
    Profile()
  ];

  List<String> titles = [
    'Appointment',
    'Accepted appointment',
    'Group session',
    'Profile',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(DoctorBottomNavState());
  }

  void changeGroupSessionStatus(int index) {
    status = index;
    emit(ChangeGroupSessionStatusState());
  }

  Doctor? doctorModel;
  void getDoctor(String uid) {
    emit(GetDoctorLoadingState());
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(uid)
        .get()
        .then((value) {
      doctorModel = Doctor.fromMap(value.data()!);
      print(doctorModel!.email);
      emit(GetDoctorSuccessState());
    }).catchError((e) {
      emit(GetDoctorErrorState());
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

  void updateDoctorProfile({
    required String name,
    required String phone,
    required String department,
    required String image,
    required String dateOfBirth,
    required String gender,
  }) {
    emit(UpdateDoctorLoadingState());
    Doctor doctor = Doctor(
        doctorModel!.id,
        name,
        dateOfBirth,
        department,
        gender,
        doctorModel!.email,
        phone,
        image,
        doctorModel!.isBlocked,
        doctorModel!.rate);
    FirebaseFirestore.instance
        .collection('Doctor')
        .doc(doctorModel!.id)
        .update(doctor.toMap()!)
        .then((value) {
      emit(UpdateDoctorSuccessState());
    }).catchError((e) {
      emit(UpdateDoctorErrorState());
    });
  }

  GroupSessionModel? groupSession;
  addGroupSession({
    required String title,
    required String description,
    required String date,
    required String time,
    required String link,
  }) async {
    emit(AddGroupSessionLoadingState());
    String docId = await generateRandomString(25);
    GroupSessionModel groupSession = GroupSessionModel(
        docId,
        title,
        description,
        date,
        time,
        link,
        'Closed',
        doctorModel!.name,
        doctorModel!.rate,
        doctorModel!.id);
    FirebaseFirestore.instance
        .collection('Session')
        .doc(docId)
        .set(groupSession.toMap()!)
        .then((value) {
      emit(AddGroupSessionSuccessState());
    }).catchError((e) {
      emit(AddGroupSessionErrorState());
    });
  }

  EditGroupSessionLinkOrStatus({
    required String link,
    required int index,
    required String status,
  }) async {
    emit(EditGroupSessionLoadingState());
    GroupSessionModel groupSession = GroupSessionModel(
        groupSessionList[index].groupId,
        groupSessionList[index].title,
        groupSessionList[index].description,
        groupSessionList[index].date,
        groupSessionList[index].time,
        link,
        status,
        groupSessionList[index].doctorName,
        groupSessionList[index].doctorRate,
        groupSessionList[index].doctorId);
    FirebaseFirestore.instance
        .collection('Session')
        .doc(groupSessionList[index].groupId)
        .update(groupSession.toMap()!)
        .then((value) {
      emit(EditGroupSessionSuccessState());
    }).catchError((e) {
      emit(EditGroupSessionErrorState());
    });
  }

  DeleteGroupSession({
    required int index,
  }) {
    FirebaseFirestore.instance
        .collection('Session')
        .doc(groupSessionList[index].groupId)
        .delete()
        .then((value) {
      toast(message: 'Session deleted successfully', data: ToastStates.success);
      emit(DeleteGroupSessionSuccessState());
    }).catchError((e) {
      emit(DeleteGroupSessionErrorState());
    });
  }

  DeleteAppointmentSession({
    required int index,
  }) {
    FirebaseFirestore.instance
        .collection('Appointment')
        .doc(acceptedAppointmentList[index].appointmentId)
        .delete()
        .then((value) {
      toast(message: 'Session deleted successfully', data: ToastStates.success);
      emit(DeleteSessionSuccessState());
    }).catchError((e) {
      emit(DeleteSessionErrorState());
    });
  }

  List<GroupSessionModel> groupSessionList = [];
  void getGroupSession() {
    groupSessionList = [];
    emit(GetGroupSessionLoadingState());
    FirebaseFirestore.instance
        .collection('Session')
        .where('doctorId', isEqualTo: doctorModel!.id)
        .get()
        .then((value) {
      for (var element in value.docs) {
        groupSessionList.add(GroupSessionModel.fromMap(element.data()));
      }
      emit(GetGroupSessionSuccessState());
    }).catchError((e) {
      emit(GetGroupSessionErrorState());
    });
  }

  List<AppointmentModel> onlineAppointmentList = [];
  List<AppointmentModel> offlineAppointmentList = [];
  List<AppointmentModel> acceptedAppointmentList = [];
  void getAllOnlineAppointment() {
    onlineAppointmentList = [];
    acceptedAppointmentList = [];
    emit(GetOfflineAppointmentLoadingState());
    FirebaseFirestore.instance
        .collection('Appointment')
        .where('doctorId', isEqualTo: doctorModel!.id)
        .where('type', isEqualTo: 'Online')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (AppointmentModel.fromMap(element.data()).status == 'Accepted') {
          acceptedAppointmentList.add(AppointmentModel.fromMap(element.data()));
        } else {
          onlineAppointmentList.add(AppointmentModel.fromMap(element.data()));
        }
      }
      emit(GetOfflineAppointmentSuccessState());
    }).catchError((e) {
      emit(GetOfflineAppointmentErrorState());
    });
  }
  void getAllOfflineAppointment() {
    offlineAppointmentList = [];
    acceptedAppointmentList = [];
    emit(GetOnlineAppointmentLoadingState());
    FirebaseFirestore.instance
        .collection('Appointment')
        .where('doctorId', isEqualTo: doctorModel!.id)
        .where('type', isEqualTo: 'At clinic')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (AppointmentModel.fromMap(element.data()).status == 'Accepted') {
          acceptedAppointmentList.add(AppointmentModel.fromMap(element.data()));
        } else {
          offlineAppointmentList.add(AppointmentModel.fromMap(element.data()));
        }
      }
      emit(GetOnlineAppointmentSuccessState());
    }).catchError((e) {
      emit(GetOnlineAppointmentErrorState());
    });
  }

  void changeAppointmentStatus({
    required String appointmentType,
    required index,
    required String status,
    String? doctorReport,
  }) {
    if(status == 'Finished'){
      String? report = doctorReport != ''
          ? doctorReport
          :acceptedAppointmentList[index].doctorReport;
      AppointmentModel appointmentModel = AppointmentModel(
        acceptedAppointmentList[index].appointmentId,
        acceptedAppointmentList[index].studentId,
        acceptedAppointmentList[index].accountType,
        acceptedAppointmentList[index].date,
        acceptedAppointmentList[index].time,
        acceptedAppointmentList[index].link,
        acceptedAppointmentList[index].type,
        acceptedAppointmentList[index].doctorId,
        acceptedAppointmentList[index].studentNickname,
        status,
        report,
        acceptedAppointmentList[index].isRated,
      );
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(acceptedAppointmentList[index].appointmentId)
          .update(appointmentModel.toMap()!)
          .then((value) {
        emit(ChangeStatusSuccessState());
      }).catchError((e) {
        emit(ChangeStatusErrorState());
      });
    }else {
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
          status,
          onlineAppointmentList[index].doctorReport,
          onlineAppointmentList[index].isRated,
        );
        FirebaseFirestore.instance
            .collection('Appointment')
            .doc(onlineAppointmentList[index].appointmentId)
            .update(appointmentModel.toMap()!)
            .then((value) {
          emit(ChangeStatusSuccessState());
        }).catchError((e) {
          emit(ChangeStatusErrorState());
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
          status,
          offlineAppointmentList[index].doctorReport,
          offlineAppointmentList[index].isRated,
        );
        FirebaseFirestore.instance
            .collection('Appointment')
            .doc(offlineAppointmentList[index].appointmentId)
            .update(appointmentModel.toMap()!)
            .then((value) {
          emit(ChangeStatusSuccessState());
        }).catchError((e) {
          emit(ChangeStatusErrorState());
        });
      }
    }
  }

  void addAppointmentLink(index, String link) {
    AppointmentModel appointmentModel = AppointmentModel(
      acceptedAppointmentList[index].appointmentId,
      acceptedAppointmentList[index].studentId,
      acceptedAppointmentList[index].accountType,
      acceptedAppointmentList[index].date,
      acceptedAppointmentList[index].time,
      link,
      acceptedAppointmentList[index].type,
      acceptedAppointmentList[index].doctorId,
      acceptedAppointmentList[index].studentNickname,
      acceptedAppointmentList[index].status,
      acceptedAppointmentList[index].doctorReport,
      acceptedAppointmentList[index].isRated,
    );
    FirebaseFirestore.instance
        .collection('Appointment')
        .doc(acceptedAppointmentList[index].appointmentId)
        .update(appointmentModel.toMap()!)
        .then((value) {
      emit(AddLinkSuccessState());
    }).catchError((e) {
      emit(AddLinkErrorState());
    });
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
