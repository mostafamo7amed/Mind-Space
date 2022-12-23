import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mind_space/app/admin/home/home_admin_view.dart';
import 'package:mind_space/app/resources/styles_manager.dart';
import '../../shared/components/component.dart';
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

  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Image.asset(ImageAssets.splashLogo),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Registration',
                      style: getBoldStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      label: 'Email Address',
                      prefix: Icon(Icons.email, color: ColorManager.primary),
                      controller: emailController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email can\'t be empty';
                        }
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                        context: context,
                        controller: passwordController,
                        label: 'Password',
                        prefix: Icon(Icons.lock, color: ColorManager.primary),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password can\'t be empty';
                          }
                          return null;
                        },
                        suffix: true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        pressedShow: () {
                          // TODO change visibility
                        },
                        isPassword: true,
                        type: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        context: context,
                        controller: conFirmPasswordController,
                        label: 'Confirm password',
                        prefix: Icon(Icons.lock, color: ColorManager.primary),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password can\'t be empty';
                          }
                          return null;
                        },
                        suffix: true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        pressedShow: () {
                          // TODO change visibility
                        },
                        isPassword: true,
                        type: TextInputType.visiblePassword),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(7)),
                      child: ToggleButtons(
                          onPressed: (index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
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
                              child: Text('Doctor',style: TextStyle(fontSize: 14),),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8),
                              child: Text('Student',style: TextStyle(fontSize: 14),),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
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
                          condition: true, //TODO loading state
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
                          //TODO Register press
                          //navigateTo(context, const HomeAdminView());
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
  }
}
