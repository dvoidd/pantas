import 'package:fl_chart/fl_chart.dart';

class SensorData {
  List<FlSpot> kelembapanTanahData = [];
  List<FlSpot> suhuData = [];
  List<FlSpot> kelembapanUdaraData = [];
  List<FlSpot> suhuTanahData = [];

  void addKelembapanTanah(FlSpot data) {
    kelembapanTanahData.add(data);
  }

  void addSuhu(FlSpot data) {
    suhuData.add(data);
  }

  void addKelembapanUdara(FlSpot data) {
    kelembapanUdaraData.add(data);
  }

  void addsuhuTanah(FlSpot data) {
    suhuTanahData.add(data);
  }
}
