import 'package:flutter/material.dart';
import 'package:google_play_book/pages/library_page.dart';
import 'package:google_play_book/widgets/menu_option_view.dart';
import 'package:google_play_book/resources/colors.dart';
import 'package:google_play_book/widgets/icon_view.dart';

class ShelfDetails extends StatefulWidget {
  const ShelfDetails({Key? key}) : super(key: key);

  @override
  State<ShelfDetails> createState() => _ShelfDetailsState();
}

class _ShelfDetailsState extends State<ShelfDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const IconView(
                  icon: Icons.keyboard_arrow_left,
                  iconColor: WHITE_COLOR,
                  iconSize: 33),
            ),
            const Spacer(),
            InkWell(
              onTap: () => showModalBottomSheet(
                context: (context),
                builder: (context) => Container(
                  height: 200,
                  color: APP_SECONDARY_COLOR,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 25),
                    child: Column(
                      children: [
                        const Text("10 Interactive Design Books to Read"),
                        const Divider(
                          color: GREY_COLOR,
                        ),
                        const MenuOptionsView(
                            menuIcon: Icons.mode_edit,
                            menuName: "Rename shelf"),
                        InkWell(
                            onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LibraryPage(),
                                  ),
                                ),
                            child: const MenuOptionsView(
                                menuIcon: Icons.delete_outline_sharp,
                                menuName: "Delete shelf"))
                      ],
                    ),
                  ),
                ),
              ),
              child: const IconView(
                  icon: Icons.more_horiz, iconColor: WHITE_COLOR, iconSize: 25),
            ),
          ],
        ),
      ),
      body: Column(children: [
        Text("10 Interaction Design Books to Read"),
        Text(" 3 books"),
        Divider(color: GREY_COLOR, thickness: 0.5,),
        FilterChip(label: Text("Not Started"), onSelected: (val){}),

      ],),
    );
  }
}
