
import 'package:flutter/cupertino.dart';

import '../class/cuaca_class.dart';
import '../services/cuaca_service.dart';

class CuacaProvider extends ChangeNotifier {
  TextEditingController cityNameText = TextEditingController();

  CuacaService cuacaService = CuacaService();
  CuacaModel cuacaModel = CuacaModel();

  showWeatherData(double lat, double lon) async {
    cuacaModel = await cuacaService.getCurrentWeather(lat,lon);
    print("$cuacaModel.list?.first?.main");
    print("cxzczczczc${cuacaModel.list?.first?.main?.temp}");

    notifyListeners();
  }
}
