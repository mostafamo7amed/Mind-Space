import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mind_space/app/student/home/home_student_cubit/states.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../home/home_student_cubit/cubit.dart';

class EditStudentProfile extends StatelessWidget {
  EditStudentProfile({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var departController = TextEditingController();
  var dateController = TextEditingController();
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    StudentCubit.getCubit(context).studentModel!.gender == 'Male' ? StudentCubit.getCubit(context).changeGender(1)  : StudentCubit.getCubit(context).changeGender(2) ;
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {
        if (state is UpdateStudentSuccessState) {
          StudentCubit.getCubit(context)
              .getStudent(CacheHelper.getData(key: 'uid'));
        }
      },
      builder: (context, state) {
        var cubit = StudentCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          appBar: AppBar(title: Text('Edit Profile')),
          body: ConditionalBuilder(
            condition: cubit.studentModel != null,
            builder: (context) {
              nameController.text = cubit.studentModel!.name!;
              phoneController.text = cubit.studentModel!.phone!;
              departController.text = cubit.studentModel!.department!;
              dateController.text = cubit.studentModel!.dateOfBirth!;
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
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
                                      cubit.imageUri=='https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg'?
                                      CircleAvatar(
                                        radius: 48,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child:
                                           CircleAvatar(
                                                radius: 55,
                                                backgroundImage: NetworkImage(
                                                    'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg'),
                                              ),
                                      ):
                                      CircleAvatar(
                                        radius: 48,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: cubit.profileImage == null
                                            ? CircleAvatar(
                                          radius: 55,
                                          backgroundImage: NetworkImage(
                                              '${cubit.studentModel!.image}'),
                                        )
                                            : CircleAvatar(
                                          radius: 55,
                                          backgroundImage: FileImage(
                                              cubit.profileImage!),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 16,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () async {
                                                await cubit.getProfileImage();
                                              },
                                              icon: Icon(
                                                IconBroken.Camera,
                                                size: 22,
                                              ),
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: ()async {
                                      cubit.deletePhoto();
                                    },
                                    icon: Icon(IconBroken.Delete,size: 22,),
                                    color: ColorManager.white,
                                  ),
                                ),
                                Text(' Delete photo', style: getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: 14) ,)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
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
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('1900-11-11'),
                                      lastDate: DateTime.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        dateController.text = DateFormat.yMMMd()
                                            .format(value)
                                            .toString();
                                      } else {
                                        dateController.text = '';
                                      }
                                    });
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date can\'t be empty';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.datetime,
                                  context: context),

                              Row(
                                children: [
                                  Text(
                                    'Gender ',
                                    style: getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: 16),
                                  ),
                                  Radio(
                                      activeColor: ColorManager.primary,
                                      focusColor: ColorManager.primary,
                                      value: 1,
                                      groupValue: cubit.gender,
                                      onChanged: (value) {
                                        cubit.changeGender(value!);
                                      }),
                                  Text(
                                    "Male",
                                    style: getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Radio(
                                      activeColor: ColorManager.primary,
                                      focusColor: ColorManager.primary,
                                      value: 2,
                                      groupValue: cubit.gender,
                                      onChanged: (value) {
                                        cubit.changeGender(value!);
                                      }),
                                  Text(
                                    "Female",
                                    style: getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: ColorManager.primary,
                                ),
                                child: MaterialButton(
                                  child: ConditionalBuilder(
                                    condition:
                                        state is! UpdateStudentLoadingState,
                                    builder: (context) => const Text(
                                      'Save Changes',
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
                                    if (formKey.currentState!.validate()) {
                                      String gender = '';
                                      String image = '';
                                      gender = _value == 1 ? 'Male' : 'Female';
                                      if(cubit.profileImage == null){
                                        image=cubit.studentModel!.image!;
                                      }else if(cubit.imageUri!=''){
                                        image= cubit.imageUri;
                                      }else{
                                        cubit.studentModel!.image!;
                                      }
                                      cubit.updateStudentProfile(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        department: departController.text,
                                        image: image,
                                        dateOfBirth: dateController.text,
                                        gender: gender,
                                      );
                                      toast(
                                          message:
                                              'profile updated successfully',
                                          data: ToastStates.success);
                                    }
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
              );
            },
            fallback: (context) => SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: ColorManager.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
