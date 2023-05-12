import 'package:flutter/material.dart';

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
          tabs: const [
            Tab(
              text: "Your Books",
            ),
            Tab(
              text: "Your Shelves",
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