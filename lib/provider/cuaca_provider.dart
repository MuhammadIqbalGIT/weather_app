
import 'package:flutter/cupertino.dart';

import '../class/cuaca_class.dart';
import '../services/cuaca_service.dart';

class CuacaProvider extends ChangeNotifier {
  TextEditingController cityNameText = TextEditingController();

  CuacaService cuacaService = CuacaService();
  CuacaModel cuacaModel = CuacaModel();

  showWeatherData(String city) async {
    cuacaModel = await cuacaService.getCurrentWeather(city);
    print(cuacaModel.weather?.first?.main);
    notifyListeners();
  }
}
