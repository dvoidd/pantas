import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _DataTableSource extends DataTableSource {
  final List<Map<String, String>> dataRecords;

  _DataTableSource(this.dataRecords);

  @override
  DataRow getRow(int index) {
    final record = dataRecords[index];
    return DataRow(
      cells: [
        DataCell(Text(record['recordNumber']!)),
        DataCell(Text(record['timestamp']!)),
        DataCell(Text(record['kondisiUdara']!)),
        DataCell(Text(record['sensor/kelembapanTanah']!)),
        DataCell(Text(record['sensor/t']!)),
        DataCell(Text(record['sensor/kelembapanUdara']!)),
        DataCell(Text(record['sensor/suhuTanah']!)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataRecords.length;

  @override
  int get selectedRowCount => 0;
}
