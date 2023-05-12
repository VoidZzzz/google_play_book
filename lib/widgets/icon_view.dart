import 'package:flutter/material.dart';
class IconView extends StatelessWidget {
  const IconView({Key? key, required this.icon, required this.iconColor, required this.iconSize, this.iconKey = const ValueKey("DefaultKey")}) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final Key iconKey;

  @override
  Widget build(BuildContext context) {
    return Icon(icon,color: iconColor,size: iconSize,key: iconKey,);
  }
}
