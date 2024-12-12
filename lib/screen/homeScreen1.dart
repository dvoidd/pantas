// controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wemos_app/controller/homeController.dart';

// view.dart

class HomeScreen1 extends StatelessWidget {
  HomeScreen1({Key? key}) : super(key: key);

  final IrrigationController controller = Get.put(IrrigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 20.0),
                _buildSensorGrid(context),
                const SizedBox(height: 20.0),
                _buildStatusCards(),
                const SizedBox(height: 20.0),
                _buildToggleButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xff50C878),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Sistem Penyiraman Otomatis",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSensorGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSensorCard(
              context,
              "Suhu Tanah",
              "assets/icon/ph.png",
              controller.suhuTanah,
              const Color(0xffAB886D),
            ),
            _buildSensorCard(
              context,
              "Kelembapan Tanah",
              "assets/icon/tanah.png",
              controller.kelembapanTanah,
              const Color(0xff798645),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSensorCard(
              context,
              "Suhu",
              "assets/icon/suhu.png",
              controller.suhu,
              const Color(0xff325886),
            ),
            _buildSensorCard(
              context,
              "Kelembapan Udara",
              "assets/icon/kelembapan.png",
              controller.kelembapanUdara,
              const Color(0xffA2D2DF),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSensorCard(
    BuildContext context,
    String title,
    String iconPath,
    RxString value,
    Color iconColor, {
    bool isCentered = false,
  }) {
    final cardWidth = isCentered
        ? MediaQuery.of(context).size.width * 0.45
        : MediaQuery.of(context).size.width * 0.45;

    return Container(
      width: cardWidth,
      height: 180,
      margin: isCentered ? const EdgeInsets.symmetric(horizontal: 0) : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Obx(() => Text(
                  value.value,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            ImageIcon(
              AssetImage(iconPath),
              size: 40.0,
              color: iconColor,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCards() {
    return Column(
      children: [
        _buildStatusCard("Kualitas Udara", controller.kualitasUdara),
        const SizedBox(height: 20.0),
        _buildStatusCard("Status Pompa", controller.statusPompa),
        const SizedBox(height: 20.0),
        _buildStatusCard("Status penyiraman", controller.statusPenyiraman),
        const SizedBox(height: 20.0),
        _buildStatusCard("Nilai Fuzzy", controller.penyiraman),
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Penyiraman Selanjutnya",
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Text(
                        controller.pukul
                            .value, // Menggunakan RxString dari controller
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        controller.tanggal
                            .value, // Menggunakan RxString dari controller
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, RxString status) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Text(
                status.value, // Menggunakan RxString dari controller
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleButton,
      child: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color:
                controller.isOn.value ? const Color(0xff2CD46F) : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xff50C878),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Text(
              controller.isOn.value ? "OFF" : "ON",
              style: TextStyle(
                fontSize: 24.0,
                color: controller.isOn.value ? Colors.white : Color(0xff50C878),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
