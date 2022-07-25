import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:macro_calculator/pages/results_page.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:macro_calculator/utils/helpers.dart';
import 'package:macro_calculator/utils/textStyles.dart';
import 'package:macro_calculator/data/calculator.dart';
import 'package:macro_calculator/widgets/my_button.dart';
import 'package:macro_calculator/widgets/my_drop_down_menu.dart';
import 'package:macro_calculator/widgets/slider.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataController = Provider.of<DataController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MinimalLocalizations.of(context).title),
        actions: [
          IconButton(
            tooltip: isThemeDark(context)
                ? MinimalLocalizations.of(context).lightMode
                : MinimalLocalizations.of(context).darkMode,
            icon: Icon(
              isThemeDark(context) ? EvaIcons.sunOutline : EvaIcons.moonOutline,
            ),
            onPressed: () =>
                Provider.of<ThemeController>(context, listen: false)
                    .toggleTheme(),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(6.0),
        children: [
          //! second container
          Tile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MinimalLocalizations.of(context).unit,
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<DistanceUnit>(
                  items: DistanceUnit.values
                      .where((u) => u != DistanceUnit.unknown)
                      .toList(),
                  value: dataController.unit!,
                  onChanged: (value) => dataController.setUnit(value),
                ),
                SizedBox(height: 8),
                Text(
                  MinimalLocalizations.of(context).raceType,
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<RaceType>(
                  items: dataController.unit == DistanceUnit.metric
                      ? RaceType.metricTypes
                      : RaceType.statuteTypes,
                  value: dataController.raceType!,
                  onChanged: (value) => dataController.setRaceType(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MinimalLocalizations.of(context).distance,
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.distanceFormat()[0],
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          dataController.distanceFormat()[1],
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.distance!,
                  minValue: RaceType.t50m.distance,
                  maxValue: RaceType.t100k.distance,
                  onChanged: (value) => dataController.setDistance(value),
                ),
              ],
            ),
          ),
          Tile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! weight slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      MinimalLocalizations.of(context).estimateFinishTime,
                      style: MyTextStyles(context).cardTitle,
                    ),
                  ],
                ),

                createInlinePicker(
                  elevation: 1,
                  value: dataController.getTimeOfDay(),
                  onChange: (value) => dataController.setFinshTime(value),
                  minuteInterval: MinuteInterval.ONE,
                  iosStylePicker: true,
                  minHour: 0,
                  displayHeader: false,
                  isOnChangeValueMode: true,
                  accentColor: Color(0xff6750a4),
                  maxHour: 23,
                  hourLabel: MinimalLocalizations.of(context).hourLabel,
                  minuteLabel: MinimalLocalizations.of(context).minuteLabel,
                  is24HrFormat: true,
                  dialogInsetPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Calculate',
        heroTag: 'fab',
        icon: Icon(Icons.done),
        label: Text('Calculate'),
        onPressed: () {
          Calculator calculator = Calculator(
            gender: dataController.gender!,
            height: dataController.height!,
            distance: dataController.distance!,
            age: dataController.age!,
            activityLevel: dataController.activityLevel!,
            goal: dataController.goal!,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                totalCalories: calculator.totalCalories(),
                carbs: calculator.carb(),
                protein: calculator.protein(),
                fats: calculator.fat(),
                bmi: calculator.bmi(),
                tdee: calculator.tdee(),
                bmiScale: calculator.bmiScale(),
              ),
            ),
          );
        },
      ),
    );
  }
}
