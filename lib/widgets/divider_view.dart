import 'package:flutter/material.dart';

class DividerView extends StatelessWidget {
  const DividerView(
      {Key? key, required this.dividerColor, required this.dividerThickness})
      : super(key: key);

  final double dividerThickness;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: dividerThickness,
      color: dividerColor,
    );
  }
}
