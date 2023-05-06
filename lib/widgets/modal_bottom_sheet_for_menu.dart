import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_play_book/data/data_vos/books_vo.dart';
import '../resources/colors.dart';
import 'menu_option_view.dart';

void showBottomSheetForMenu(BuildContext context, BooksVO? bookDetails) {
  showModalBottomSheet(
    context: (context),
    builder: (context) => Container(
      height: 320,
      color: WHITE_COLOR,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 45,
                    child: Image.network(bookDetails?.bookImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(bookDetails?.title ?? "",
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Text(bookDetails?.author ?? "",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              " - Ebook",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: GREY_COLOR,
            ),
            const SizedBox(
              height: 17,
            ),
            const MenuOptionsView(
              menuIcon: Icons.remove_circle_outline,
              menuName: "Remove download",
            ),
            const SizedBox(
              height: 17,
            ),
            const MenuOptionsView(
              menuIcon: Icons.delete_outline,
              menuName: "Delete from your library",
            ),
            const SizedBox(
              height: 17,
            ),
            const MenuOptionsView(
              menuIcon: Icons.bookmark_add_outlined,
              menuName: "Add to wishlist",
            ),
            const SizedBox(
              height: 17,
            ),
            const MenuOptionsView(
              menuIcon: Icons.add,
              menuName: "Add to shelves",
            ),
            const SizedBox(
              height: 17,
            ),
            const MenuOptionsView(
              menuIcon: Icons.bookmark_border,
              menuName: "About this book",
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    ),
  );
}