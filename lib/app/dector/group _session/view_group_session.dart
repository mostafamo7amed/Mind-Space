import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class ViewGroupSession extends StatelessWidget {
  const ViewGroupSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group session'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Address : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "Riyadh",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "Closed",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "20 Jun 2023",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Time : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "9:00 AM",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Link : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Linkify(
                        onOpen: _onOpen,
                        style: getSemiBoldStyle(color: ColorManager.blue,fontSize: 14),
                        text: "https://galaxystore.samsung.com/games?langCd=ar",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description : ",
                      style: getSemiBoldStyle(
                          color: ColorManager.darkGray, fontSize: 16),
                    ),
                    Expanded(
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightBlue)),
                    onPressed: () {
                      //ToDo view user
                    },
                    child: Text(
                      "Edit",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () {
                      //ToDo block user
                    },
                    child: Text(
                      "Delete",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
