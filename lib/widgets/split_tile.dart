import 'package:flutter/material.dart';
import 'package:macro_calculator/pages/results_page.dart';
import 'package:macro_calculator/utils/enums.dart';

import 'package:macro_calculator/utils/textStyles.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';

class SplitTile extends StatelessWidget {
  const SplitTile({
    Key? key,
    required this.title,
    required this.unit,
    required this.splits,
  }) : super(key: key);

  final String title;
  final DistanceUnit unit;
  final List<RunSplit> splits;

  List<TableRow> getTableRows(BuildContext context) {
    List<TableRow> list = [];
    list.add(getTableHeaders(context));
    list.addAll(getTableContent(context));
    return list;
  }

  List<TableRow> getTableContent(BuildContext context) {
    List<TableRow> rows = [];
    for (var split in splits) {
      TableRow row = TableRow(
        children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitNo,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitTime,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitDistance,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  TableRow getTableHeaders(BuildContext context) {
    return TableRow(
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(MinimalLocalizations.of(context).lapNo,
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(MinimalLocalizations.of(context).lapTime,
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
              '${MinimalLocalizations.of(context).lapDistance}(${unit.unit2})',
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = getTableRows(context);
    return Tile(
      child: Column(
        children: [
          Text(title, style: MyTextStyles(context).resultCardText),
          Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: tableRows),
        ],
      ),
    );
  }
}
