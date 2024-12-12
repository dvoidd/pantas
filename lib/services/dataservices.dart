import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wemos_app/model/model_data.dart';

class SensorDataProvider with ChangeNotifier {
  SensorData _sensorData = SensorData();

  SensorData get sensorData => _sensorData;

  void initializeDataStreams() {
    final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();
    int _xValue = 0;

    _databaseRef.child('kelembapanTanah').onValue.listen((event) {
      addKelembapanTanah(FlSpot(_xValue.toDouble(),
          double.parse(event.snapshot.value?.toString() ?? '0')));
      _xValue++;
    });

    _databaseRef.child('suhu').onValue.listen((event) {
      addSuhu(FlSpot(_xValue.toDouble(),
          double.parse(event.snapshot.value?.toString() ?? '0')));
      _xValue++;
    });

    _databaseRef.child('kelembapanUdara').onValue.listen((event) {
      addKelembapanUdara(FlSpot(_xValue.toDouble(),
          double.parse(event.snapshot.value?.toString() ?? '0')));
      _xValue++;
    });
    _databaseRef.child('suhuTanah').onValue.listen((event) {
      addsuhuTanah(FlSpot(_xValue.toDouble(),
          double.parse(event.snapshot.value?.toString() ?? '0')));
      _xValue++;
    });
  }

  void addKelembapanTanah(FlSpot data) {
    _sensorData.addKelembapanTanah(data);
    notifyListeners();
  }

  void addSuhu(FlSpot data) {
    _sensorData.addSuhu(data);
    notifyListeners();
  }

  void addKelembapanUdara(FlSpot data) {
    _sensorData.addKelembapanUdara(data);
    notifyListeners();
  }

  void addsuhuTanah(FlSpot data) {
    _sensorData.addsuhuTanah(data);
    notifyListeners();
  }
}
