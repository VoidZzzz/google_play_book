import 'package:flutter/material.dart';
import 'package:google_play_book/widgets/shelf_view.dart';
import 'package:google_play_book/widgets/text_view.dart';

import '../data/data_vos/shelf_vo.dart';
import '../resources/colors.dart';

class ShelvesView extends StatelessWidget {
  const ShelvesView(
      {Key? key, required this.shelfList, required this.onTapShelf})
      : super(key: key);

  final List<ShelfVO> shelfList;
  final Function(ShelfVO) onTapShelf;

  @override
  Widget build(BuildContext context) {
    return (shelfList.isNotEmpty)
        ? ListView.builder(
            itemCount: shelfList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onTapShelf(
                shelfList[index],
              ),
              child: ShelfView(
                shelf: shelfList[index],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            // color: Colors.red,
            child: const Center(
                child: TextView(
              text: "Empty",
              fontSize: 20,
              fontColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
            )),
          );
  }
}
