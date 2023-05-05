import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_play_book/widgets/text_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../resources/colors.dart';

class RatingOverViewWithProgressBarIndicator extends StatelessWidget {
  const RatingOverViewWithProgressBarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          SizedBox(
            // color: Colors.red,
            height: 120,
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const TextView(
                  text: "4.3",
                  fontSize: 50,
                  fontColor: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                RatingBar.builder(
                  initialRating: 4.0,
                  itemCount: 5,
                  unratedColor: GREY_COLOR,
                  allowHalfRating: true,
                  itemSize: 16,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  ),
                  onRatingUpdate: (val) {},
                ),
                const SizedBox(
                  height: 5,
                ),
                const TextView(
                  text: "155 total",
                  fontSize: 13,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 100,
            width: 250,
            // color: Colors.pink,
            child: Column(
              children: [
                LinearPercentIndicator(
                  percent: 0.8,
                  progressColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  backgroundColor: Colors.black12,
                  lineHeight: 10,
                  barRadius: const Radius.circular(5),
                  leading: const TextView(
                    text: "5",
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                ),
                LinearPercentIndicator(
                  percent: 0.1,
                  progressColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  backgroundColor: Colors.black12,
                  lineHeight: 10,
                  barRadius: const Radius.circular(5),
                  leading: const TextView(
                    text: "4",
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                ),
                LinearPercentIndicator(
                  percent: 0.07,
                  progressColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  backgroundColor: Colors.black12,
                  lineHeight: 10,
                  barRadius: const Radius.circular(5),
                  leading: const TextView(
                    text: "3",
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                ),
                LinearPercentIndicator(
                  percent: 0.05,
                  progressColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  backgroundColor: Colors.black12,
                  lineHeight: 10,
                  barRadius: const Radius.circular(5),
                  leading: const TextView(
                    text: "2",
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                ),
                LinearPercentIndicator(
                  percent: 0.1,
                  progressColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                  backgroundColor: Colors.black12,
                  lineHeight: 10,
                  barRadius: const Radius.circular(5),
                  leading: const TextView(
                    text: "1",
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.black87,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

