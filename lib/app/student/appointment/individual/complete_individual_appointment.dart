import 'package:flutter/material.dart';
import 'package:mind_space/shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/styles_manager.dart';

class CompleteIndividualAppointment extends StatelessWidget {
  String appointmentType;
  CompleteIndividualAppointment(this.appointmentType,{Key? key}) : super(key: key);
  var nameController = TextEditingController();
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
                padding: const EdgeInsets.only(right: 20,left: 20,top: 10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 210,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.7,color: Colors.grey),
                        ),
                        child: CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2050-11-11'),
                            onDateChanged: (value) {

                            },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Available Today',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 20),),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('Book appointment',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                                Spacer(),
                                Text('10:00 AM',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('Book appointment',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                                Spacer(),
                                Text('11:00 AM',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('Book appointment',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                                Spacer(),
                                Text('1:00 AM',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('Book appointment',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                                Spacer(),
                                Text('3:00 AM',style: getRegularStyle(color: ColorManager.darkGray,fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
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
            addNicknameDialog(context);
          },
        ),
        SizedBox(height: 15,),
      ],
    ),
  );


  Future addNicknameDialog(context) => showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Spacer(),
                  ImageIcon(AssetImage(ImageAssets.point),
                    size: 12,
                    color: ColorManager.error,
                  ),
                ],
              ),
              Text(
                "Add Nickname",
                style: getBoldStyle(
                    color: ColorManager.darkGray, fontSize: 18),
              ),
              SizedBox(height: 15,),
              defaultFormField(
                  controller: nameController,
                  label: 'Nickname',
                  validate: (value){
                    if(value.isEmpty){
                      return 'Nickname can not be empty';
                    }
                    return null;
                  },
                  type: TextInputType.text,
                  context: context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      //ToDo view user
                    },
                    child: Text(
                      "Book",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    },
  );
}
