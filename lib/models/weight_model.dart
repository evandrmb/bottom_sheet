import 'package:meta/meta.dart';

@immutable
class WeightModel {
  final double value;
  final DateTime date;

  const WeightModel({required this.value, required this.date});
}
