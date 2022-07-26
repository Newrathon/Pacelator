import 'package:flutter/material.dart';

import 'package:macro_calculator/utils/textStyles.dart';
import 'package:macro_calculator/widgets/tile.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        children: [
          Text(title, style: MyTextStyles(context).resultCardValue),
        ],
      ),
    );
  }
}
