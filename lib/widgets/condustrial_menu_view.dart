import 'package:flutter/material.dart';
class CondustrialMenuView extends StatelessWidget {
  const CondustrialMenuView({
    Key? key,
    required this.onTapMenu,
  }) : super(key: key);

  final Function onTapMenu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapMenu(),
      child: const Icon(
        Icons.more_horiz,
        color: Colors.black54,
        size: 25,
      ),
    );
  }
}