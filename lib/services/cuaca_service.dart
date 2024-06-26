
import 'dart:ffi';

import 'package:dio/dio.dart';

import '../class/cuaca_class.dart';

class CuacaService {
  final dio = Dio();

  Future<CuacaModel> getCurrentWeather(double lat,double lon) async {

    // double lat = -6.200000;
    // double lon = 106.816666;

    final responseApi = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=035c9f27888c259afb0c5f53291485cd');
    print("test data ${responseApi.requestOptions.path}");
    //  print(responseApi.requestOptions.path);

    return CuacaModel.fromJson(responseApi.data);
  }
}
