import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  final RxList<FlSpot> kualitasUdaraData = <FlSpot>[].obs;
  final RxList<FlSpot> kelembapanTanahData = <FlSpot>[].obs;
  final RxList<FlSpot> suhuData = <FlSpot>[].obs;
  final RxList<FlSpot> kelembapanUdaraData = <FlSpot>[].obs;
  final RxList<FlSpot> suhuTanahData = <FlSpot>[].obs;

  RxInt xValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDataListeners();
  }

  void initializeDataListeners() {
    // Kualitas Udara Listener
    _databaseRef.child('sensor/kondisiUdara').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double value = double.tryParse(event.snapshot.value.toString()) ?? 0;
        _updateChartData(kualitasUdaraData, value);
      }
    });

    // Kelembapan Tanah Listener
    _databaseRef.child('sensor/kelembapanTanah').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double value = double.tryParse(event.snapshot.value.toString()) ?? 0;
        _updateChartData(kelembapanTanahData, value);
      }
    });

    // Suhu Listener
    _databaseRef.child('sensor/t').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double value = double.tryParse(event.snapshot.value.toString()) ?? 0;
        _updateChartData(suhuData, value);
      }
    });

    // Kelembapan Udara Listener
    _databaseRef.child('sensor/kelembapanUdara').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double value = double.tryParse(event.snapshot.value.toString()) ?? 0;
        _updateChartData(kelembapanUdaraData, value);
      }
    });

    // Suhu Tanah Listener
    _databaseRef.child('sensor/suhuTanah').onValue.listen((event) {
      if (event.snapshot.value != null) {
        double value = double.tryParse(event.snapshot.value.toString()) ?? 0;
        _updateChartData(suhuTanahData, value);
      }
    });
  }

  void _updateChartData(RxList<FlSpot> dataList, double value) {
    final currentX = xValue.value.toDouble();
    dataList.add(FlSpot(currentX, value));

    // Keep only the last 10 points
    if (dataList.length > 10) {
      dataList.removeAt(0);
      // Adjust x-coordinates for remaining points
      for (int i = 0; i < dataList.length; i++) {
        dataList[i] = FlSpot(i.toDouble(), dataList[i].y);
      }
    }
    xValue++;
  }

  LineChart buildLineChart(List<FlSpot> data, Color color, String title) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: false,
            color: color,
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 40,
              getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 20,
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
