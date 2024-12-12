import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wemos_app/controller/chartController.dart';

class ChartPage1 extends GetView<ChartController> {
  ChartPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildChartSection("Suhu Tanah (°C)", controller.suhuTanahData,
                    Color(0xffAB886D), "Suhu Tanah"),
                _buildChartSection(
                    "Kelembapan Tanah (%)",
                    controller.kelembapanTanahData,
                    Color(0xff798645),
                    "Kelembapan Tanah"),
                _buildChartSection("Suhu (°C)", controller.suhuData,
                    Color(0xff325886), "Suhu"),
                _buildChartSection(
                    "Kelembapan Udara (%)",
                    controller.kelembapanUdaraData,
                    Color(0xffA2D2DF),
                    "Kelembapan Udara"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection(
      String title, RxList<FlSpot> data, Color color, String chartTitle) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200,
          child: Obx(() => controller.buildLineChart(data, color, chartTitle)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChartController());
  }
}
