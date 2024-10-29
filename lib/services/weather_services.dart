import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  final Dio dio;
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = 'b3efc53ac0652b72da1759908dbdf12c';

  WeatherServices(this.dio);

  Future<WeatherModel> getWeather(String cityName) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'q': cityName,          
          'appid': apiKey,
          'units': 'metric',       
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch current weather');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      throw e;
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placeMark[0].locality;

    return city ?? "";
  }
}
