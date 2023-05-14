
import 'package:flutter/material.dart';
import 'package:google_play_book/widgets/sort_button_view.dart';

class SortingViews extends StatelessWidget {
  const SortingViews(
      {Key? key,
        required this.viewTypeValue,
        required this.onTapSortByMenu,
        required this.sortByValue,
        required this.onTapViewTypeMenu})
      : super(key: key);

  final int viewTypeValue;
  final int sortByValue;
  final Function onTapSortByMenu;
  final Function onTapViewTypeMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          InkWell(
            onTap: () => onTapSortByMenu(),
            child: SortButtonView(sortByValue: sortByValue),
          ),
          const Spacer(),
          InkWell(
            onTap: () => onTapViewTypeMenu(),
            child: Icon(
              (viewTypeValue == 1)
                  ? Icons.view_list_outlined
                  : Icons.view_module_outlined,
              color: Colors.black54,key: const ValueKey("ViewLayoutKey"),
            ),
          ),
        ],
      ),
    );
  }
}