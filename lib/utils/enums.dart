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
  statute(unit1: "yr", unit2: "mi", unit3: ""),
  metric(unit1: "m", unit2: "km", unit3: ""),
  unknown(unit1: "", unit2: "", unit3: "");

  const DistanceUnit({
    required this.unit1,
    required this.unit2,
    required this.unit3,
  });
  final String unit1;
  final String unit2;
  final String unit3;
}

const double MILE_TO_METER = 1609.34;

enum RaceType {
  tCustomized(distance: 0, unit: DistanceUnit.unknown),
  t1mi(distance: 1 * MILE_TO_METER, unit: DistanceUnit.statute),
  t13mi(distance: 13.109 * MILE_TO_METER, unit: DistanceUnit.statute),
  t26mi(distance: 26.218 * MILE_TO_METER, unit: DistanceUnit.statute),

  t50m(distance: 50, unit: DistanceUnit.metric),
  t100m(distance: 100, unit: DistanceUnit.metric),
  t800m(distance: 800, unit: DistanceUnit.metric),
  t1000m(distance: 1000, unit: DistanceUnit.metric),
  t5k(distance: 5000, unit: DistanceUnit.metric),
  t10k(distance: 10000, unit: DistanceUnit.metric),
  t21k(distance: 21097.5, unit: DistanceUnit.metric),
  t30k(distance: 30000, unit: DistanceUnit.metric),
  t42k(distance: 42195, unit: DistanceUnit.metric),
  t50k(distance: 50000, unit: DistanceUnit.metric),
  t100k(distance: 100000, unit: DistanceUnit.metric);

  const RaceType({
    required this.distance,
    required this.unit,
  });
  final double distance;
  final DistanceUnit unit;

  static List<RaceType> get metricTypes =>
      RaceType.values.where((t) => t.unit != DistanceUnit.statute).toList();
  static List<RaceType> get statuteTypes =>
      RaceType.values.where((t) => t.unit != DistanceUnit.metric).toList();
}
