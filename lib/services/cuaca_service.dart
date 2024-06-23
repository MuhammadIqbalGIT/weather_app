
import 'package:dio/dio.dart';

import '../class/cuaca_class.dart';

class CuacaService {
  final dio = Dio();

  Future<CuacaModel> getCurrentWeather(String cityName) async {
    // HTTP Request
    final responseApi = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=035c9f27888c259afb0c5f53291485cd&units=metric');
    print(responseApi.requestOptions.path);
    // Convert
    return CuacaModel.fromJson(responseApi.data);
  }
}
