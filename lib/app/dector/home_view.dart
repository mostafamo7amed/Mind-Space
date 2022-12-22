import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mind_space/app/resources/assets_manager.dart';
import 'package:mind_space/app/resources/styles_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                ImageAssets.wave,
                alignment: Alignment.topCenter,
              ),
              Text("data",style: getSemiBoldStyle(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
