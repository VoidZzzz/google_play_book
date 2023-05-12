import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data_vos/books_vo.dart';
import '../pages/book_details_page.dart';
import 'condustrial_menu_view.dart';
import 'modal_bottom_sheet_for_menu.dart';
class BooksListView extends StatelessWidget {
  const BooksListView(
      {Key? key,
        required this.savedBookList,
        required this.onTapAddToShelfInBookListView})
      : super(key: key);

  final List<BooksVO>? savedBookList;
  final Function(int) onTapAddToShelfInBookListView;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: savedBookList?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetails(
                          bookDetails: savedBookList?[index], bookLists: null),
                    ),
                  ),
                  child: Container(
                    height: 80,
                    width: 55,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      savedBookList?[index].bookImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        savedBookList?[index].title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        savedBookList?[index].author ?? "",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Ebook-sample",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.download_done,
                  color: Colors.black87,
                  size: 20,
                ),
                CondustrialMenuView(
                  onTapMenu: () => showBottomSheetForMenu(
                      context, savedBookList?[index], () {
                    onTapAddToShelfInBookListView(index);
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}