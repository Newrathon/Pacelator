import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:flutter/material.dart';

class DataController extends ChangeNotifier {
  DistanceUnit? unit;
  RaceType? raceType; //类型
  double? distance; //距离
  int? finishTimeHour; //完成时间小时
  int? finishTimeMinute; //完成时间分钟
  int? paceMinute;
  int? paceSecond;
  TabMode? tabMode;

  Box box = Hive.box('data');

  DataController() {
    this.finishTimeHour = box.get('finishTimeHour') ?? 0;
    this.finishTimeMinute = box.get('finishTimeMinute') ?? 0;

    this.paceMinute = box.get('paceMinute') ?? 0;
    this.paceSecond = box.get('paceSecond') ?? 0;
    this.distance = box.get('distance') ?? 1000;
    this.tabMode = TabMode.values[box.get('tabModeIndex') ?? 0];
    this.unit = DistanceUnit.values[box.get('unit') ?? 1];
    this.raceType = RaceType.values[box.get('raceType') ?? 0];
  }

  void setDistance(double? distance) {
    this.distance = distance;
    box.put('distance', distance);
    //If changed, it means start a customized type
    this.raceType = RaceType.tCustomized;
    box.put('raceType', RaceType.tCustomized.index);
    notifyListeners();
  }

  TabMode getTabMode() {
    return this.tabMode!;
  }

  int getTabInitialIndex() {
    return this.tabMode!.index;
  }

  void setUnit(DistanceUnit? unit) {
    this.unit = unit;
    box.put('unit', unit?.index);
    this.raceType = RaceType.tCustomized;
    box.put('raceType', RaceType.tCustomized.index);
    notifyListeners();
  }

  void setRaceType(RaceType? raceType) {
    this.raceType = raceType;
    box.put('raceType', raceType?.index);
    if (raceType != RaceType.tCustomized) {
      this.distance = raceType?.distance;
      box.put('distance', this.distance);
    }
    notifyListeners();
  }

  void setFinishedTime(TimeOfDay? timeOfDay) {
    this.finishTimeHour = timeOfDay?.hour;
    box.put('finishTimeHour', this.finishTimeHour);
    this.finishTimeMinute = timeOfDay?.minute;
    box.put('finishTimeMinute', this.finishTimeMinute);

    notifyListeners();
  }

  void setPace(TimeOfDay? timeOfDay) {
    this.paceMinute = timeOfDay?.hour;
    box.put('paceMinute', this.paceMinute);
    this.paceSecond = timeOfDay?.minute;
    box.put('paceSecond', this.paceSecond);
    notifyListeners();
  }

  void setTabMode(int? tabIndex) {
    this.tabMode = TabMode.values[tabIndex ?? 0];
    box.put('tabModeIndex', tabIndex);
    notifyListeners();
  }

  List<RaceType> getRaceType() {
    return unit == DistanceUnit.metric
        ? RaceType.metricTypes
        : RaceType.statuteTypes;
  }

  TimeOfDay getPaceMinuteSecondTime() {
    return TimeOfDay.now()
        .replacing(hour: this.paceMinute, minute: this.paceSecond);
  }

  TimeOfDay getFinishedHourMinuteTime() {
    return TimeOfDay.now()
        .replacing(hour: this.finishTimeHour, minute: this.finishTimeMinute);
  }

  List<String> distanceFormatted() {
    if (unit == DistanceUnit.metric) {
      if (distance! <= 1000) {
        return ["${distance!.toStringAsFixed(0)}", "${unit!.unit1}"];
      } else {
        if (distance == 21097.5) {
          return ["21.0975", "${unit!.unit2}"];
        }
        if (distance == 42195) {
          return ["42.195", "km"];
        }
      }
    } else if (unit == DistanceUnit.statute) {
      return [
        "${(distance! / MILE_TO_METER).toStringAsFixed(1)}",
        "${unit!.unit2}"
      ];
    }
    return ["${(distance! / 1000).toStringAsFixed(1)}", "${unit!.unit2}"];
  }
}
