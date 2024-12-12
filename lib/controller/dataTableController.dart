import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DataTableController extends GetxController {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  // Observable list of records
  var dataRecords = <Map<String, String>>[].obs;

  // Counter untuk nomor record
  var recordCounter = 1;

  @override
  void onInit() {
    super.onInit();
    _initializeFirebaseListeners();
  }

  void _initializeFirebaseListeners() {
    _databaseRef.onValue.listen((event) {
      final snapshot = event.snapshot.value as Map?;
      final sensorData = snapshot!['sensor'] as Map?;
      if (snapshot != null) {
        final newRecord = {
          'recordNumber': recordCounter.toString(), // Tambahkan nomor record
          'timestamp': DateTime.now().toString(),
          'kondisiUdara': sensorData?['kondisiUdara']?.toString() ?? '0',
          'kelembapanTanah': sensorData?['kelembapanTanah']?.toString() ?? '0',
          't': sensorData?['t']?.toString() ?? '0',
          'kelembapanUdara': sensorData?['kelembapanUdara']?.toString() ?? '0',
          'suhuTanah': sensorData?['suhuTanah']?.toString() ?? '0',
        };

        // Update the observable list
        dataRecords.add(newRecord);

        // Increment counter
        recordCounter++;
      }
    });
  }

  @override
  void onClose() {
    _databaseRef.onDisconnect(); // Clean up listeners
    super.onClose();
  }
}
