import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors.dart';
import 'menu_option_view.dart';

void showBottomSheetForMenu(BuildContext context) {
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
                    child: Image.network(
                      "https://www.pixelstalk.net/wp-content/uploads/2016/08/Breaking-Bad-HD-Wallpaper-for-Iphone.jpg",
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
                          "Viking: The taking over Rome",
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Thomas Ipsum",
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