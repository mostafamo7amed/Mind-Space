import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';
import 'package:mind_space/app/dector/home/home_cubit/states.dart';

import '../../accepted_appointment/accepted_appointment.dart';
import '../../appointement/appointment.dart';
import '../../group _session/group_session.dart';
import '../../profile/profile.dart';

class DoctorCubit extends Cubit<DoctorStates> {
  DoctorCubit() : super(DoctorInitState());

  static DoctorCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

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


}
