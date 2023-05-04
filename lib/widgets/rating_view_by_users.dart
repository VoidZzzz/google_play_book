import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../resources/colors.dart';

class RatingViewByUsers extends StatelessWidget {
  const RatingViewByUsers(
      {Key? key,
        required this.userName,
        required this.reviewDate,
        required this.userComment,
        required this.userImage})
      : super(key: key);

  final String userImage;
  final String userName;
  final String userComment;
  final String reviewDate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  userImage,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            height: 130,
            width: 296,
            // color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: userName,
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: APP_TERTIARY_COLOR,
                      ),
                      onRatingUpdate: (val) {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextView(
                      text: reviewDate,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontColor: Colors.white54,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextView(
                  text: userComment,
                  fontColor: Colors.white70,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const TextView(
                      text: "Was this review helpful?",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    const Spacer(),
                    Container(
                      height: 28,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: WHITE_COLOR),
                          color: APP_PRIMARY_COLOR),
                      child: const Center(
                        child: TextView(
                          text: "Yes",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 28,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: WHITE_COLOR),
                          color: APP_PRIMARY_COLOR),
                      child: const Center(
                        child: TextView(
                          text: "No",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}