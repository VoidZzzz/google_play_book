import 'package:flutter/material.dart';

import '../data/data_vos/books_vo.dart';
import '../pages/book_details_page.dart';
import '../pages/book_view.dart';
import 'modal_bottom_sheet_for_menu.dart';
class SmallGridView extends StatelessWidget {
  const SmallGridView(
      {Key? key,
        required this.savedBookList,
        required this.onTapAddToShelfInMenu})
      : super(key: key);

  final List<BooksVO>? savedBookList;
  final Function(int) onTapAddToShelfInMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: savedBookList?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.54),
        itemBuilder: (context, index) => BookView(
          imageHeight: 170,
          imageWidth: 170,
          titleWidth: 170,
          bottomDownloadPadding: 56,
          downloadIconSize: 15,
          leftSamplePadding: 15,
          topSamplePadding: 3,
          sampleMargin: 3,
          titleColor: Colors.black87,
          authorColor: Colors.black54,
          sampleFontSize: 13,
          onTapMenu: () => showBottomSheetForMenu(
            context,
            savedBookList?[index],
                () => onTapAddToShelfInMenu(index),
          ),
          bookCover: savedBookList?[index].bookImage ?? "",
          bookName: savedBookList?[index].title ?? "",
          bookAuthorName: savedBookList?[index].author ?? "",
          onTapBookView: () {
            navigateToDetailsPage(context, index);
          },
        ),
      ),
    );
  }

  Future<dynamic> navigateToDetailsPage(BuildContext context, int index) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            BookDetails(bookDetails: savedBookList?[index], bookLists: null),
      ),
    );
  }
}