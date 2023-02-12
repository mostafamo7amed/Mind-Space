import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_space/app/forget_password/forget_password.dart';
import 'package:mind_space/app/login/login_cubit/states.dart';
import 'package:mind_space/app/register/register_view.dart';
import 'package:mind_space/app/resources/styles_manager.dart';
import '../../shared/components/component.dart';
import '../../shared/network/local/cache_helper.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'login_cubit/cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            CacheHelper.saveData(key: 'uid', data: state.uid);
            print('state id == ${state.uid}');
            uid = state.uid;
            LoginCubit.getCubit(context).findUser(state.uid, context);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.getCubit(context);
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
                          Text(
                            'Login',
                            style: getBoldStyle(color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          defaultFormField(
                            context: context,
                            label: 'Email Address',
                            prefix: Icon(Icons.email,color: ColorManager.primary),
                            controller: emailController,
                            validate: (value) {
                              if (!value.contains('.edu.sa')||value!.isEmpty||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)) {
                                return 'Please enter valid email address ';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            autofill: [AutofillHints.email],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              label: 'Password',
                              prefix: Icon(Icons.lock, color: ColorManager.primary),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter correct password';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePasswordVisibility();
                              },
                              isPassword: cubit.isPassword,
                              type: TextInputType.visiblePassword),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: const ButtonStyle(minimumSize:MaterialStatePropertyAll(Size.zero)),
                                onPressed: () {
                                  navigateTo(context, ForgetPasswordView());
                                },
                                child: Text(
                                  'Forget password?',
                                  style: getSemiBoldStyle(color: ColorManager.darkGray),
                                ),
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
                                condition: state is! LoginLoadingState,
                                builder: (context) => const Text(
                                  'LOGIN',
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
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(email: emailController.text, password: passwordController.text,context: context);
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: getSemiBoldStyle(color: ColorManager.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterView());
                                },
                                child: Text(
                                  'Register Now',
                                  style: getSemiBoldStyle(color: ColorManager.primary),
                                ),
                              ),
                            ],
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
