import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_cubit/states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitState());

  static AdminCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [

  ];

  List<String> titles = [
    'Home',
    'Chats',
    'new Post',
    'Location',
    'Settings',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AdminBottomNavState());
  }


}
