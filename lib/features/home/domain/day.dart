import 'package:json_annotation/json_annotation.dart';
import 'package:weather/utils/custom_date_time_converter.dart';

part 'day.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class Day {
  Day({
    required this.dt_txt,
    required this.main,
    required this.wind,
    required this.weather,
  });

  DateTime dt_txt;
  WeatherMain main;
  Wind wind;
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
    required this.humidity,
  });

  double temp;
  double temp_min;
  double temp_max;
  double pressure;
  double sea_level;
  double humidity;

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class WeatherDay {
  WeatherDay({
    required this.main,
    required this.description,
    required this.icon,
  });

  String main;
  String description;
  String icon;

  factory WeatherDay.fromJson(Map<String, dynamic> json) =>
      _$WeatherDayFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDayToJson(this);
}


@JsonSerializable()
class Wind {
  Wind({
    required this.speed,
  });

  double speed;

  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}