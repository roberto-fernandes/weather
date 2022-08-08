import 'package:json_annotation/json_annotation.dart';
import 'package:weather/features/home/domain/city.dart';
import 'package:weather/features/home/domain/day.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  City city;
  List<Day> list;

  Weather({
    required this.city,
    required this.list,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
