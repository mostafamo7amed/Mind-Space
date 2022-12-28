import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mind_space/shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class CompleteIndividualAppointment extends StatelessWidget {
  String appointmentType;
  CompleteIndividualAppointment(this.appointmentType,{Key? key}) : super(key: key);
  var dateController = TextEditingController();
  var timeController =TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select date and time'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14, bottom: 15),
                  child: Row(children: [
                    Text("${appointmentType} appointment",
                        style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSizeManager.s24)),
                    const Spacer(),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          ImageAssets.photo,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: timeController,
                      label: 'Appointment Time',
                      prefix: Icon(Icons.watch_later_outlined,color: ColorManager.primary,),
                      onTap: (){
                        showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: Colors.grey,
                                  onPrimary: Colors.black,
                                  surface: ColorManager.white,
                                  onSurface: ColorManager.darkPrimary,
                                ),
                                dialogBackgroundColor:Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        ).then((value) {
                          if(value != null) {
                            timeController.text = value.format(context);
                          }else {
                            timeController.text = '';
                          }
                        });

                      },
                      validate: (value){
                        if(value.isEmpty){
                          return 'Time can\'t be empty';
                        }
                        return null;
                      },
                      type: TextInputType.number, context: context,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: dateController,
                        label: 'Appointment Date',
                        prefix: Icon(Icons.calendar_today,color: ColorManager.primary,),
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2050-11-11'),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: ColorScheme.dark(
                                      primary: Colors.grey,
                                      onPrimary: Colors.black,
                                      surface: ColorManager.primary,
                                      onSurface: ColorManager.darkPrimary,
                                    ),
                                    dialogBackgroundColor:Colors.white,
                                  ),
                                  child: child!,
                                );
                              },
                          ).then((value) {
                            if(value != null) {
                              dateController.text = DateFormat.yMMMd().format(value).toString();
                            }else {
                              dateController.text = '';
                            }
                          });


                        },
                        validate: (value){
                          if(value.isEmpty){
                            return 'Date can\'t be empty';
                          }
                          return null;
                        },
                        type: TextInputType.number, context: context),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                      'Book',
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

                   //todo booking
                    if(appointmentType == 'Online'){
                      showModalBottomSheet(
                        backgroundColor: ColorManager.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        context: context,
                        builder: (context) =>
                            bottomSheetBuilder(context),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheetBuilder(context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                  color: ColorManager.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              height: 4,
            ),
          ),
        ),
        Text(
          'Choose Account Type',
          style:
          getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        SizedBox(height: 10,),
        InkWell(
          child: Card(
              margin: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(IconBroken.Profile,size: 35,color: ColorManager.gray,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Visible",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(IconBroken.Arrow___Right_2,color: ColorManager.gray,),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Card(
              margin: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(IconBroken.Profile,size: 35,color: ColorManager.gray,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Hidden",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(IconBroken.Arrow___Right_2,color: ColorManager.gray,),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(height: 15,),
      ],
    ),
  );
}
