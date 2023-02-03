import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/create_account/create_account.dart';
import 'package:mind_space/app/register/register_cubit/cubit.dart';
import 'package:mind_space/app/register/register_cubit/states.dart';
import 'package:mind_space/app/resources/styles_manager.dart';
import '../../shared/components/component.dart';
import '../../shared/network/local/cache_helper.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var conFirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            CacheHelper.saveData(key: 'uid', data: state.id);
            uid = state.id;
            String userType  ='';
            userType = isSelected[0]==true? 'Doctor':'Student';
            print('============= user type $userType ================');
            navigateTo(context,
              CreateAccount(
                state.id,
                userType,
                emailController.text,
                passwordController.text,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.getCubit(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(ImageAssets.splashLogo,fit:BoxFit.cover,),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Registration',
                            style:
                                getBoldStyle(color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            context: context,
                            label: 'Email Address',
                            prefix:
                                Icon(Icons.email, color: ColorManager.primary),
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                      .hasMatch(value!)) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              label: 'Password',
                              prefix:
                                  Icon(Icons.lock, color: ColorManager.primary),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePasswordVisibility();
                              },
                              isPassword: cubit.isPassword,
                              type: TextInputType.visiblePassword),
                          defaultFormField(
                              context: context,
                              controller: conFirmPasswordController,
                              label: 'Confirm password',
                              prefix:
                                  Icon(Icons.lock, color: ColorManager.primary),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm password';
                                }else if(passwordController.text!=conFirmPasswordController.text){
                                  return 'Password not matches';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword2
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePassword2Visibility();
                              },
                              isPassword: cubit.isPassword2,
                              type: TextInputType.visiblePassword),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(7)),
                            child: ToggleButtons(
                                onPressed: (index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      if (i == index) {
                                        isSelected[i] = true;
                                      } else {
                                        isSelected[i] = false;
                                      }
                                    }
                                  });
                                },
                                color: Colors.black,
                                fillColor: ColorManager.primary,
                                selectedColor: Colors.white,
                                focusColor: Colors.white,
                                renderBorder: false,
                                borderRadius: BorderRadius.circular(7),
                                isSelected: isSelected,
                                children: const <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8),
                                    child: Text(
                                      'Doctor',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8),
                                    child: Text(
                                      'Student',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
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
                                condition: state is! RegisterLoadingState,
                                builder: (context) => const Text(
                                  'Register',
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
                                  cubit.register(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
