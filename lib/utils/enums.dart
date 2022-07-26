enum Gender {
  male,
  female,
}

enum ActivityLevel {
  sedentary,
  lightly,
  moderately,
  very,
  extremely,
}

enum Goal {
  loose,
  maintain,
  gain,
}

enum DistanceUnit {
  statute(
      l10nKey: "distanceUnit:statute",
      unit1: "yr",
      unit2: "mi",
      unit3: "minPerMi"),
  metric(
      l10nKey: "distanceUnit:metric",
      unit1: "m",
      unit2: "km",
      unit3: "minPerKm"),
  unknown(l10nKey: "distanceUnit:unknown", unit1: "", unit2: "", unit3: "");

  const DistanceUnit({
    required this.l10nKey,
    required this.unit1,
    required this.unit2,
    required this.unit3,
  });
  final String l10nKey;
  final String unit1;
  final String unit2;
  final String unit3;
}

double getDividerForDistanceUnit(DistanceUnit unit) {
  if (unit == DistanceUnit.statute) {
    return MILE_TO_METER;
  }
  return 1000;
}

const double MILE_TO_METER = 1609.34;

enum TabMode {
  estimatedFinishTime,
  paceExpected,
}

enum RaceType {
  tCustomized(
      distance: 0, unit: DistanceUnit.unknown, l10nKey: "raceType:customized"),
  t1mi(
      distance: 1 * MILE_TO_METER,
      unit: DistanceUnit.statute,
      l10nKey: "raceType:1mi"),
  t13mi(
      distance: 13.109 * MILE_TO_METER,
      unit: DistanceUnit.statute,
      l10nKey: "raceType:13mi"),
  t26mi(
      distance: 26.218 * MILE_TO_METER,
      unit: DistanceUnit.statute,
      l10nKey: "raceType:26mi"),

  t50m(distance: 50, unit: DistanceUnit.metric, l10nKey: "raceType:50m"),
  t100m(distance: 100, unit: DistanceUnit.metric, l10nKey: "raceType:100m"),
  t800m(distance: 800, unit: DistanceUnit.metric, l10nKey: "raceType:800m"),
  t1000m(distance: 1000, unit: DistanceUnit.metric, l10nKey: "raceType:1000m"),
  t5k(distance: 5000, unit: DistanceUnit.metric, l10nKey: "raceType:5k"),
  t10k(distance: 10000, unit: DistanceUnit.metric, l10nKey: "raceType:10k"),
  t21k(distance: 21097.5, unit: DistanceUnit.metric, l10nKey: "raceType:21k"),
  t30k(distance: 30000, unit: DistanceUnit.metric, l10nKey: "raceType:30k"),
  t42k(distance: 42195, unit: DistanceUnit.metric, l10nKey: "raceType:42k"),
  t50k(distance: 50000, unit: DistanceUnit.metric, l10nKey: "raceType:50k"),
  t100k(distance: 100000, unit: DistanceUnit.metric, l10nKey: "raceType:100k");

  const RaceType({
    required this.distance,
    required this.unit,
    required this.l10nKey,
  });
  final double distance;
  final DistanceUnit unit;
  final String l10nKey;

  static List<RaceType> get metricTypes =>
      RaceType.values.where((t) => t.unit != DistanceUnit.statute).toList();
  static List<RaceType> get statuteTypes =>
      RaceType.values.where((t) => t.unit != DistanceUnit.metric).toList();
}
