import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/create_account/create_account_cubit/states.dart';
import 'package:mind_space/app/student/home/home_student_view.dart';

import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../doctor/home/home_doctor_view.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import 'create_account_cubit/cubit.dart';

class CreateAccount extends StatelessWidget {
  String id;
  String accountType;
  String email;
  String password;
  CreateAccount(this.id,this.accountType,this.email,this.password,{Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var departController = TextEditingController();
  var dateController = TextEditingController();
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCubit(),
      child: BlocConsumer<CreateCubit,CreateStates>(
       listener: (context, state) {
       },
       builder: (context, state) {
         var cubit = CreateCubit.getCubit(context);
         return Scaffold(
           backgroundColor: ColorManager.background,
           body: SafeArea(
             child: Form(
               key: formKey,
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: 170,
                       child: Stack(
                         alignment: Alignment.topCenter,
                         children: [
                           Align(
                             alignment: Alignment.topCenter,
                             child: SvgPicture.asset(
                               ImageAssets.wave,
                               alignment: Alignment.topCenter,
                               fit: BoxFit.fill,
                             ),
                           ),
                           Align(
                             alignment: Alignment.bottomCenter,
                             child: Container(
                               width: 117,
                               child: Stack(
                                 alignment: Alignment.bottomCenter,
                                 children: [
                                   CircleAvatar(
                                     radius: 45,
                                     backgroundColor:
                                     Theme.of(context).scaffoldBackgroundColor,
                                     child: const CircleAvatar(
                                       radius: 42,
                                       backgroundImage: AssetImage(
                                         ImageAssets.photo,
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Align(
                                       alignment: Alignment.bottomRight,
                                       child: CircleAvatar(
                                         radius: 16,
                                         child: Icon(
                                           IconBroken.Camera,
                                           color: ColorManager.white,
                                         ),
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         children: [
                           Text(
                             'Create $accountType Account',
                             style: getBoldStyle(color: Colors.black, fontSize: 20),
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           defaultFormField(
                               controller: nameController,
                               label: 'Name',
                               validate: (value) {
                                 if (value!.isEmpty) {
                                   return 'Name can\'t be empty';
                                 }
                                 return null;
                               },
                               type: TextInputType.text,
                               context: context),
                           defaultFormField(
                               context: context,
                               controller: phoneController,
                               label: 'Phone Number',
                               validate: (value) {
                                 if (value!.isEmpty) {
                                   return 'phone can\'t be empty';
                                 }
                                 return null;
                               },
                               pressedShow: () {
                                 // TODO change visibility
                               },
                               isPassword: true,
                               type: TextInputType.number),
                           defaultFormField(
                               controller: departController,
                               label: 'Department',
                               validate: (value) {
                                 if (value!.isEmpty) {
                                   return 'Department can\'t be empty';
                                 }
                                 return null;
                               },
                               type: TextInputType.text,
                               context: context),
                           defaultFormField(
                               controller: dateController,
                               label: 'Date',
                               validate: (value) {
                                 if (value!.isEmpty) {
                                   return 'Date can\'t be empty';
                                 }
                                 return null;
                               },
                               type: TextInputType.datetime,
                               context: context),
                           Row(children: [
                             Text('Gender ',style: getRegularStyle(color: ColorManager.black, fontSize: 16),),
                             SizedBox(width: 5,),
                             Radio(
                                 activeColor: ColorManager.primary,
                                 focusColor:ColorManager.primary ,value: 1, groupValue: _value,
                                 onChanged: (value){

                             }),
                             Text("Male",style: getRegularStyle(color: ColorManager.black, fontSize: 16),),
                             SizedBox(width: 10,),
                             Radio(
                                 activeColor: ColorManager.primary,
                                 focusColor:ColorManager.primary ,value: 2, groupValue: _value,
                                 onChanged: (value){

                             }),
                             Text("Female",style: getRegularStyle(color: ColorManager.black, fontSize: 16),),
                           ],),
                           Container(
                             width: double.infinity,
                             height: 40,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(7),
                               color: ColorManager.primary,
                             ),
                             child: MaterialButton(
                               child: ConditionalBuilder(
                                 condition: state is! CreateUserLoadingState, //TODO loading state
                                 builder: (context) => const Text(
                                   'Create Account',
                                   style: TextStyle(
                                     color: Colors.white,
                                   ),
                                 ),
                                 fallback: (context) => const SizedBox(
                                   height: 25,
                                   width: 25,
                                   child: CircularProgressIndicator(
                                     strokeWidth: 3,
                                     backgroundColor: Colors.white,
                                   ),
                                 ),
                               ),
                               onPressed: () {
                                 /*if(formKey.currentState!.validate()){
                                   cubit.createUser(
                                       userType: accountType,
                                       email: email,
                                       name: nameController.text,
                                       phone: phoneController.text,
                                       id: id,
                                       department: departController.text,
                                       image: image,
                                       dateOfBirth: dateController.text,
                                       gender: gender,
                                       isBlocked: false,
                                   );*/
                                   if(accountType == 'Doctor'){
                                     navigateAndFinish(context, HomeDoctorView());
                                   }else{
                                     navigateAndFinish(context, HomeStudentView());
                                   }
                                // }

                               },
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         );
       },
      ),
    );
  }
}
