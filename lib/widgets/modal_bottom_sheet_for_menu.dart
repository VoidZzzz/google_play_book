import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors.dart';
import 'menu_option_view.dart';

void showBottomSheetForMenu(BuildContext context) {
  showModalBottomSheet(
    context: (context),
    builder: (context) => Container(
      height: 320,
      color: APP_SECONDARY_COLOR,
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
                    child: Image.asset(
                      "images/dummyBookList.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Business Approach in 2025",
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: WHITE_COLOR,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Thomas Ipsum",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                            Text(
                              " - Ebook",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white54,
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