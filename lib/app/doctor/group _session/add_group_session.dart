import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mind_space/app/doctor/group%20_session/group_session.dart';
import 'package:mind_space/app/doctor/home/home_cubit/cubit.dart';
import 'package:mind_space/app/doctor/home/home_cubit/states.dart';
import '../../../shared/components/component.dart';
import '../../resources/color_manager.dart';

class AddGroupSession extends StatelessWidget {
  AddGroupSession({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorStates>(
      listener: (context, state) {
        if(state is AddGroupSessionSuccessState){
          DoctorCubit.getCubit(context).getGroupSession();
          toast(message: 'Group session added successfully', data: ToastStates.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = DoctorCubit.getCubit(context);
        return Scaffold(
          backgroundColor: ColorManager.background,
          appBar: AppBar(title: Text('Add Group Session')),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          defaultFormField(
                              controller: titleController,
                              label: 'Title',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Title can\'t be empty';
                                }
                                return null;
                              },
                              type: TextInputType.text,
                              context: context),
                          defaultFormField(
                              context: context,
                              controller: descriptionController,
                              label: 'Description',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Description can\'t be empty';
                                }
                                return null;
                              },
                              type: TextInputType.text),
                          defaultFormField(
                              controller: dateController,
                              label: 'Date',
                              onTap: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2090-11-11'),
                                ).then((value) {
                                  if(value != null) {
                                    dateController.text = DateFormat.yMMMd().format(value).toString();
                                  }else {
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
                          defaultFormField(
                              controller: timeController,
                              label: 'Time',
                              onTap: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()
                                ).then((value) {
                                  if(value != null) {
                                    timeController.text = value.format(context);
                                  }else {
                                    timeController.text = '';
                                  }
                                });

                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Time can\'t be empty';
                                }
                                return null;
                              },
                              type: TextInputType.datetime,
                              context: context),
                          defaultFormField(
                              controller: linkController,
                              label: 'Link',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Link can\'t be empty';
                                }
                                return null;
                              },
                              type: TextInputType.text,
                              context: context),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: ColorManager.primary,
                            ),
                            child: MaterialButton(
                              child: ConditionalBuilder(
                                condition: state is !AddGroupSessionLoadingState,
                                builder: (context) => const Text(
                                  'Save Session',
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
                                  cubit.addGroupSession(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      date: dateController.text,
                                      time: timeController.text,
                                      link: linkController.text
                                  );
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
          ),
        );
      },
    );
  }
}
