import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class ViewFeedbacks extends StatelessWidget {
  const ViewFeedbacks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbacks'),
      ),
      body: Column(
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: const CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              ImageAssets.photo,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Ali mohamed ali ali mohamed ali ali mohamed ali ali mohamed ali",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Container(
                child: CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 15,
                  percent: 60 / 100,
                  animation: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  animationDuration: 2000,
                  center: Text(
                    '60%',
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 25),
                  ),
                  progressColor: ColorManager.primary,
                ),
              ),
              SizedBox(height: 20,),
              RatingBar.builder(
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (value) {
                  //todo change rating double
                },
                minRating: 3,
                ignoreGestures: true,
                allowHalfRating: true,
                updateOnDrag: true,
                unratedColor: Colors.grey,
                glowColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
