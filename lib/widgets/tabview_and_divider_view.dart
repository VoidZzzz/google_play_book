import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';

class TabViewAndDividerVIew extends StatelessWidget {
  const TabViewAndDividerVIew({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelColor: Colors.black54,
          labelColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          indicatorColor: LIGHT_THEME_SELECTED_CHIP_COLOR,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "Your Books",
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                key: const ValueKey("TabOne"),
              ),
            ),
            Tab(
              child: Text(
                "Your Shelves",
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                key: const ValueKey("2"),
              ),
            ),
          ],
        ),
        const Divider(
          color: GREY_COLOR,
        )
      ],
    );
  }
}
