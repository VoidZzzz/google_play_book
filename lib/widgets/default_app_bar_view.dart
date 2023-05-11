import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/widgets/text_view.dart';
import '../resources/colors.dart';

class DefaultAppBarView extends StatelessWidget {
  const DefaultAppBarView({Key? key, required this.onTapSearch})
      : super(key: key);

  final Function onTapSearch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapSearch(),
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(8),
              color: WHITE_COLOR),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.68,
                      height: 44,
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: TextView(
                            text: "Search Play Books",
                            fontColor: Colors.black54,
                            fontSize: 16, fontWeight: FontWeight.w500,
                          )),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset("images/cat2.jpg"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
