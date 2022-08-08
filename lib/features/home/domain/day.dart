import 'package:json_annotation/json_annotation.dart';

part 'day.g.dart';

@JsonSerializable()
class Day {
  Day({
    required this.dt_txt,
    required this.main,
    required this.weather,
  });

  String dt_txt;
  WeatherMain main;
  List<WeatherDay> weather;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class WeatherMain {
  WeatherMain({
    required this.temp,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.sea_level,
  });

  double temp;
  double temp_min;
  double temp_max;
  double pressure;
  double sea_level;

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class WeatherDay {
  WeatherDay({
    required this.main,
    required this.description,
  });

  String main;
  String description;

  factory WeatherDay.fromJson(Map<String, dynamic> json) =>
      _$WeatherDayFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDayToJson(this);
}
