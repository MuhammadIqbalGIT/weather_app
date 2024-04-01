import 'package:final_project_cuaca/provider/cuaca_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCity = 'Jakarta'; // Default dipilih Jakarta

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CuacaProvider>(context, listen: false)
          .showWeatherData(_selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuacaProvider>(context);
    final List<String> cities = [
      'Jakarta',
      'Bandung',
      'Bogor',
      'Cianjur'
      'Cirebon'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Cuaca Kelompok"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Kelompok 99",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Anggota Kelompok'),
            const Text('Dhaffa Satria Pratama - Ketua Kelompok'),
            const Text('Aqil Faqih Github'),
            const Text('Yulian Dewantara'),
            const Text('Muhammad Iqbal'),

            DropdownButtonFormField<String>(
              value: _selectedCity,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Pilih Kota',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue!;
                });
                provider.showWeatherData(_selectedCity);
              },
              items: cities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     provider.showWeatherData(_selectedCity);
            //   },
            //   child: Text("Tampilkan Data Cuaca"),
            // ),
            const SizedBox(height: 20),
            Consumer<CuacaProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    const Text(
                      "Kota yang anda pilih :",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      provider.cuacaModel.name ?? "",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(provider.cuacaModel.weather?.first.main ?? ""),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        "https://openweathermap.org/img/w/${provider.cuacaModel.weather?.first.icon}.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                        "Temperature kota : ${provider.cuacaModel.main?.temp} Celcius"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
