import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class IrrigationController extends GetxController {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  final RxBool isOn = false.obs;
  final RxBool isDisabled = false.obs;
  final RxString kualitasUdara = '0'.obs;
  final RxString kelembapanTanah = '0'.obs;
  final RxString suhu = '0'.obs;
  final RxString kelembapanUdara = '0'.obs;
  final RxString suhuTanah = '0'.obs;
  final RxString statusPompa = 'false'.obs;
  final RxString statusPenyiraman = 'MATI'.obs;
  final RxString penyiraman = '0'.obs;
  final RxString pukul = '--:--'.obs;
  final RxString tanggal = '0000-00-00'.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDataStreams();
    _listenToButtonStatus();
  }

  void _listenToButtonStatus() {
    _databaseRef.child('statusTombol').onValue.listen((event) {
      // Ambil status tombol dari Firebase
    });
  }

  void _initializeDataStreams() {
    // Listen to Kualitas Udara updates
    _databaseRef.child('sensor/kondisiUdara').onValue.listen(
      (event) {
        kualitasUdara.value = '${event.snapshot.value?.toString() ?? 'Baik'}';
      },
      onError: (error) => print('Error retrieving Kualitas Udara: $error'),
    );

    // Listen to Kelembapan Tanah updates
    _databaseRef.child('sensor/kelembapanTanah').onValue.listen(
      (event) {
        kelembapanTanah.value = '${event.snapshot.value?.toString() ?? '0'} %';
      },
      onError: (error) => print('Error retrieving kelembapan tanah: $error'),
    );

    // Listen to Suhu updates
    _databaseRef.child('sensor/t').onValue.listen(
      (event) {
        suhu.value = '${event.snapshot.value?.toString() ?? '0'} °C';
      },
      onError: (error) => print('Error retrieving suhu: $error'),
    );

    // Listen to Kelembapan Udara updates
    _databaseRef.child('sensor/kelembapanUdara').onValue.listen(
      (event) {
        kelembapanUdara.value = '${event.snapshot.value?.toString() ?? '0'} %';
      },
      onError: (error) => print('Error retrieving kelembapan udara: $error'),
    );

    // Listen to Suhu Tanah updates
    _databaseRef.child('sensor/suhuTanah').onValue.listen(
      (event) {
        suhuTanah.value = '${event.snapshot.value?.toString() ?? '0'} °C';
      },
      onError: (error) => print('Error retrieving Suhu Tanah: $error'),
    );

    // Listen to Status Pompa
    _databaseRef.child('StatusPompa').onValue.listen(
      (event) {
        statusPompa.value = event.snapshot.value?.toString() ?? 'false';
      },
      onError: (error) => print('Error retrieving statusPompa: $error'),
    );

    // Listen to Status Penyiraman
    _databaseRef.child('statusPenyiraman').onValue.listen(
      (event) {
        statusPenyiraman.value = event.snapshot.value?.toString() ?? 'MATI';
      },
      onError: (error) => print('Error retrieving statusPenyiraman: $error'),
    );

    // Listen to Penyiraman
    _databaseRef.child('fuzzy/penyiraman').onValue.listen(
      (event) {
        penyiraman.value = event.snapshot.value?.toString() ?? '0';
      },
      onError: (error) => print('Error retrieving penyiraman: $error'),
    );

    _databaseRef.child('jadwalPenyiraman/selanjutnyaPukul').onValue.listen(
      (event) {
        pukul.value = event.snapshot.value?.toString() ?? '--:--';
      },
      onError: (error) => print('Error retrieving pukul: $error'),
    );

    _databaseRef.child('jadwalPenyiraman/selanjutnyaTanggal').onValue.listen(
      (event) {
        tanggal.value = event.snapshot.value?.toString() ?? '0000-00-00';
      },
      onError: (error) => print('Error retrieving Tanggal: $error'),
    );
  }

  void disableButton() {
    isDisabled.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      isDisabled.value = false;
    });
  }

  Future<void> updateFirebaseStatus(bool status) async {
    try {
      await _databaseRef.child('statusTombol').set(status);
      await _databaseRef.child('StatusPompa').set(status);
    } catch (error) {
      Get.snackbar(
        'Error',
        'Gagal mengupdate status ke database',
        duration: const Duration(seconds: 2),
      );
      // Revert the local state if Firebase update fails
      isOn.value = !status;
    }
  }

  void toggleButton() async {
    if (isDisabled.value) {
      Get.snackbar(
        'Notice',
        'Tombol tidak dapat ditekan selama 5 detik',
        duration: const Duration(seconds: 5),
      );
      return;
    }

    // Update local state immediately for responsive UI
    isOn.value = !isOn.value;

    // Update Firebase
    await updateFirebaseStatus(isOn.value);

    // If turning off, disable the button
    if (!isOn.value) {
      disableButton();
    }
  }
}
