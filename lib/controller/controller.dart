import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherController extends GetxController {
  final WeatherServices _weatherServices = WeatherServices(Dio());

  WeatherModel? weathers;

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      String cityName = await _weatherServices.getCurrentLocation();
      final weather = await _weatherServices.getWeather(cityName);
      weathers = weather;
      update();
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }
}
