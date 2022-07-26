import 'dart:math';

import 'package:flutter/material.dart';
import 'package:macro_calculator/pages/results_page.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:macro_calculator/utils/number_format.dart';

class Calculator {
  final double distance;
  final TabMode tabMode;
  final TimeOfDay pace;
  final TimeOfDay etf;
  final RaceType raceType;
  final DistanceUnit unit;

  Calculator({
    required this.distance,
    required this.tabMode,
    required this.pace,
    required this.etf,
    required this.raceType,
    required this.unit,
  });

  String estimatedTimeFinished() {
    if (this.tabMode == TabMode.estimatedFinishTime) {
      return "${formatNumLeftPadding0(etf.hour)}:${formatNumLeftPadding0(etf.minute)}:00";
    } else {
      //pace * distance
      //Here hour is minute actually
      int secondsPerKm = pace.hour * 60 + pace.minute;
      int totalTimeInSecond = (distance / 1000 * secondsPerKm).toInt();
      int hours = totalTimeInSecond ~/ 3600;
      int minutes = (totalTimeInSecond % 3600) ~/ 60;
      int seconds = totalTimeInSecond % 3600 % 60;
      return "${formatNumLeftPadding0(hours)}:${formatNumLeftPadding0(minutes)}:${formatNumLeftPadding0(seconds)}";
    }
  }

  String averagePace() {
    if (this.tabMode == TabMode.estimatedFinishTime) {
      //etf/distance
      int etfInSecond = etf.hour * 3600 + etf.minute * 60;
      int speedInSecond =
          etfInSecond ~/ (distance / getDividerForDistanceUnit(unit));
      int hours = (speedInSecond ~/ 3600);
      int minutes = (speedInSecond % 3600) ~/ 60;
      int seconds = speedInSecond % 3600 % 60;
      return "${hours == 0 ? '' : formatNumLeftPadding0(hours)}:${formatNumLeftPadding0(minutes)}:${formatNumLeftPadding0(seconds)}";
    } else {
      //Here hour is minute actually
      return "${formatNumLeftPadding0(pace.hour)}:${formatNumLeftPadding0(pace.minute)}";
    }
  }

  List<RunSplit> splits() {
    return [];
  }
}
