class DataRecord {
  final String kualitasUdara;
  final String kelembapanTanah;
  final String suhu;
  final String kelembapanUdara;
  final String suhuTanah;
  final DateTime timestamp;

  DataRecord({
    required this.kualitasUdara,
    required this.kelembapanTanah,
    required this.suhu,
    required this.kelembapanUdara,
    required this.suhuTanah,
    required this.timestamp,
  });
}
