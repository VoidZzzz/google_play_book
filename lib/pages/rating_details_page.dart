import 'package:flutter/material.dart';
import 'package:google_play_book/custom_components/smart_list_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';
import 'package:google_play_book/widgets/rating_overview_with_progress_bar_indicator.dart';
import 'package:google_play_book/widgets/rating_view_by_users.dart';
import 'package:google_play_book/widgets/text_view.dart';

class RatingDetailsPage extends StatelessWidget {
  const RatingDetailsPage({Key? key}) : super(key: key);

  final List<String> ratingChips = const ["5", "4", "3", "2", "1"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitleView(),
        leading: const AppBarLeadingVIew(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: SmartHorizontalListView(
                    itemCount: ratingChips.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: FilterChip(
                              selectedColor: LIGHT_THEME_TERTIARY_COLOR,
                              side: const BorderSide(
                                  color: GREY_COLOR, width: 0.5),
                              backgroundColor: WHITE_COLOR,
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 1),
                              label: Row(
                                children: [
                                  TextView(
                                    text: ratingChips[index],
                                    fontColor: GREY_COLOR,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const IconView(
                                      icon: Icons.star,
                                      iconColor: GREY_COLOR,
                                      iconSize: 20),
                                ],
                              ),
                              onSelected: (isSelected) {}),
                        ),
                    onListEndReached: () {},
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const RatingOverViewWithProgressBarIndicator(),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingViewByUsers(
                  userName: "Sophia Lee",
                  reviewDate: "Nov 1, 2022",
                  userComment:
                      "Really good story to read. Definitely worth my time",
                  userImage: "images/cat2.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarLeadingVIew extends StatelessWidget {
  const AppBarLeadingVIew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconView(
        icon: Icons.keyboard_arrow_left, iconColor: WHITE_COLOR, iconSize: 30);
  }
}

class AppBarTitleView extends StatelessWidget {
  const AppBarTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextView(
      text: "Ratings and reviews",
      fontSize: 20,
    );
  }
}
