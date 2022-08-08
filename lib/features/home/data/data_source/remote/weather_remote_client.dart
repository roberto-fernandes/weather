
import 'package:retrofit/retrofit.dart';
import 'package:weather/features/home/domain/weather.dart';
import 'package:dio/dio.dart' show Dio, Options, RequestOptions, ResponseType;

part 'weather_remote_client.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5")
abstract class WeatherRemoteClient {
  factory WeatherRemoteClient(Dio dio, {String baseUrl}) = _WeatherRemoteClient;

  @GET("/forecast/")
  Future<Weather> getWeather({
    @Query("lat") required double lat,
    @Query("lon") required double lon,
    @Query("cnt") required int cnt,
    @Query("units") required String units,
    @Query("appid") required String appid,
  });
}
