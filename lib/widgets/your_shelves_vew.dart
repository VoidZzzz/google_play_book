import 'package:flutter/material.dart';
import 'package:google_play_book/widgets/shelves_view.dart';

import '../data/data_vos/shelf_vo.dart';
import '../pages/library_page.dart';
import '../pages/shelf_details.dart';
import 'create_new_button.dart';

class YourShelvesView extends StatelessWidget {
  const YourShelvesView(
      {Key? key, required this.shelfList, required this.onTapCreateNewShelf})
      : super(key: key);

  final List<ShelfVO>? shelfList;
  final Function onTapCreateNewShelf;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShelvesView(
          shelfList: shelfList ?? [],
          onTapShelf: (shelf) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ShelfDetails(
                shelf: shelf,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () => onTapCreateNewShelf(),
            child: const CreateNewButton(),
          ),
        ),
      ],
    );
  }
}