import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class AddGroupSession extends StatelessWidget {
  AddGroupSession({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(title: Text('Add Group Session')),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: addressController,
                          label: 'Address',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                          type: TextInputType.text,
                          context: context),
                      const SizedBox(
                        height: 10,
                      ),
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
                          pressedShow: () {
                            // TODO change visibility
                          },
                          isPassword: true,
                          type: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: timeController,
                          label: 'Time',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Time can\'t be empty';
                            }
                            return null;
                          },
                          type: TextInputType.datetime,
                          context: context),
                      const SizedBox(
                        height: 10,
                      ),
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
                            //TODO login press
                            //navigateTo(context, HomeDoctorView());
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
  }
}
