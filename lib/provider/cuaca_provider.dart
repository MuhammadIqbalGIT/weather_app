
import 'package:flutter/cupertino.dart';

import '../model/cuaca_model.dart';
import '../service/cuaca_service.dart';

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
