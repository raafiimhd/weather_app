import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/controller.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
      ),
      body: Center(
        child: GetBuilder<WeatherController>(
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.weathers?.cityName ?? 'Loading City',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
                Text(
                  "${controller.weathers?.temperature.round()}°C",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
            ],
          ),
        ),
      ),
    );
  }
}
