import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';
import 'package:mind_space/app/models/student.dart';
import '../../../../shared/components/component.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../models/admin.dart';
import '../../../models/appointment.dart';
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

  List<AppointmentModel> allAppointmentList=[];
  void getAllAppointment() {
    allAppointmentList = [];
    emit(GetAllAppointmentLoadingState());
    FirebaseFirestore.instance
        .collection('Individual Session')
        .get()
        .then((value) {
      for (var element in value.docs) {
        allAppointmentList.add(AppointmentModel.fromMap(element.data()));
      }
      emit(GetAllAppointmentSuccessState());
    }).catchError((e) {
      emit(GetAllAppointmentErrorState());
    });
  }

  List<AppointmentModel> searchAppointmentList=[];
  void search(String value){
    searchAppointmentList = allAppointmentList.where((element) {
      String date = element.type!.toLowerCase();
      return date.contains(value.toLowerCase());
    }).toList();
    emit(ChangeSearchListState());
  }

  DeleteAppointmentSession({
    required int index,
    required bool isSearch
  }) {
    if(isSearch){
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(searchAppointmentList[index].appointmentId)
          .delete()
          .then((value) {
        toast(message: 'Session deleted successfully', data: ToastStates.success);
        emit(DeleteSessionSuccessState());
      }).catchError((e) {
        emit(DeleteSessionErrorState());
      });
    }else{
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(allAppointmentList[index].appointmentId)
          .delete()
          .then((value) {
        toast(message: 'Session deleted successfully', data: ToastStates.success);
        emit(DeleteSessionSuccessState());
      }).catchError((e) {
        emit(DeleteSessionErrorState());
      });
    }
  }

  void addAppointmentLink({
    required int index,
    required String link,
    required bool isSearch
  }) {
    if(isSearch){
      AppointmentModel appointmentModel = AppointmentModel(
        searchAppointmentList[index].appointmentId,
        searchAppointmentList[index].studentId,
        searchAppointmentList[index].accountType,
        searchAppointmentList[index].date,
        searchAppointmentList[index].time,
        link,
        searchAppointmentList[index].type,
        searchAppointmentList[index].doctorId,
        searchAppointmentList[index].studentNickname,
        searchAppointmentList[index].status,
        searchAppointmentList[index].doctorReport,
        searchAppointmentList[index].isRated,
      );
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(searchAppointmentList[index].appointmentId)
          .update(appointmentModel.toMap()!)
          .then((value) {
        toast(message: 'Session edited successfully', data: ToastStates.success);
        emit(AddLinkSuccessState());
      }).catchError((e) {
        emit(AddLinkErrorState());
      });
    }else{
      AppointmentModel appointmentModel = AppointmentModel(
        allAppointmentList[index].appointmentId,
        allAppointmentList[index].studentId,
        allAppointmentList[index].accountType,
        allAppointmentList[index].date,
        allAppointmentList[index].time,
        link,
        allAppointmentList[index].type,
        allAppointmentList[index].doctorId,
        allAppointmentList[index].studentNickname,
        allAppointmentList[index].status,
        allAppointmentList[index].doctorReport,
        allAppointmentList[index].isRated,
      );
      FirebaseFirestore.instance
          .collection('Appointment')
          .doc(allAppointmentList[index].appointmentId)
          .update(appointmentModel.toMap()!)
          .then((value) {
        toast(message: 'Session edited successfully', data: ToastStates.success);
        emit(AddLinkSuccessState());
      }).catchError((e) {
        emit(AddLinkErrorState());
      });
    }

  }
}
