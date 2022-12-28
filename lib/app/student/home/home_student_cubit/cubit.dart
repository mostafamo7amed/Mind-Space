import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentInitState());

  static StudentCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [

  ];

  List<String> titles = [
    'Appointment',
    'Accepted appointment',
    'Group session',
    'Profile',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(StudentBottomNavState());
  }


}
