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
        title: Text("Pace Calculator"),
        actions: [
          IconButton(
            tooltip: isThemeDark(context) ? 'Light Mode' : 'Dark Mode',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Distance",
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.distanceFormat()[0],
                          style: MyTextStyles(context).homeCardValue,
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

                //! weight slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Estimated Time Finished",
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
                  value: dataController.finishTime!,
                  minValue: 40,
                  maxValue: 150,
                  onChanged: (value) => dataController.setDistance(value),
                ),
                // age number picker
                Text(
                  "Age",
                  style: MyTextStyles(context).cardTitle,
                ),
                Center(
                  child: NumberPicker(
                    minValue: 12,
                    maxValue: 80,
                    itemCount: 7,
                    itemWidth: 47.2,
                    selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: TextStyle(color: colorScheme(context).tertiary),
                    value: dataController.age!,
                    axis: Axis.horizontal,
                    onChanged: (value) => dataController.setAge(value),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
