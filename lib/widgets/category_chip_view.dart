import 'package:flutter/material.dart';

import '../resources/colors.dart';

class CategoryChipView extends StatelessWidget {
  const CategoryChipView(
      {Key? key,
      required this.categoryChipLabels,
      required this.isShowClearButton,
      required this.chipIsSelected,
      required this.onTapClearButtonInChipView,
      required this.onTapCategoryChip})
      : super(key: key);

  final List<String> categoryChipLabels;
  final bool isShowClearButton;
  final List<bool> chipIsSelected;
  final Function onTapClearButtonInChipView;
  final Function(bool, int) onTapCategoryChip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            Visibility(
              visible: isShowClearButton,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15, left: 8),
                child: InkWell(
                  key: const ValueKey("ClearButton"),
                  onTap: () => onTapClearButtonInChipView(),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(18),
                        color: WHITE_COLOR),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryChipLabels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FilterChip(
                    key: const ValueKey("Chip"),
                    backgroundColor: WHITE_COLOR,
                    side: (chipIsSelected[index])
                        ? const BorderSide(color: WHITE_COLOR)
                        : const BorderSide(color: GREY_COLOR),
                    selectedColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
                    showCheckmark: false,
                    label: Text(
                      categoryChipLabels[index],
                      style: TextStyle(
                        color: chipIsSelected[index] ? Colors.white : null,
                      ),
                    ),
                    selected: chipIsSelected[index],
                    onSelected: (val) {
                      onTapCategoryChip(val, index);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
