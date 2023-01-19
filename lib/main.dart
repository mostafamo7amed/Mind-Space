import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/admin/home/home_cubit/cubit.dart';
import 'package:mind_space/app/student/home/home_student_cubit/cubit.dart';
import 'package:mind_space/shared/network/local/cache_helper.dart';
import 'package:mind_space/shared/observer/blocObserver.dart';
import 'app/doctor/home/home_cubit/cubit.dart';
import 'app/resources/theme_manager.dart';
import 'app/splash/splash_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminCubit()..getDoctor()..getStudent(),),
        BlocProvider(create: (context) => DoctorCubit(),),
        BlocProvider(create: (context) => StudentCubit()..getAllDoctors(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mind Space',
        theme: getApplicationTheme(),
        home: const SplashView(),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

