import 'package:flutter/material.dart';

import '../data/data_vos/books_vo.dart';
import '../pages/book_details_page.dart';
import '../pages/book_view.dart';
import 'modal_bottom_sheet_for_menu.dart';
class LargeGridView extends StatelessWidget {
  const LargeGridView({Key? key, required this.savedBookList})
      : super(key: key);

  final List<BooksVO>? savedBookList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 15.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: savedBookList?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.625),
        itemBuilder: (context, index) => BookView(
          imageHeight: 250,
          imageWidth: 170,
          titleWidth: 170,
          titleColor: Colors.black87,
          authorColor: Colors.black54,
          rightMenuPadding: 5,
          bottomDownloadPadding: 49,
          rightDownloadPadding: 6,
          onTapMenu: () =>
              showBottomSheetForMenu(context, savedBookList?[index], () {}),
          bookCover: savedBookList?[index].bookImage ?? "",
          bookName: savedBookList?[index].title ?? "",
          bookAuthorName: savedBookList?[index].author ?? "",
          onTapBookView: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BookDetails(
                  bookDetails: savedBookList?[index], bookLists: null),
            ),
          ),
        ),
      ),
    );
  }
}
