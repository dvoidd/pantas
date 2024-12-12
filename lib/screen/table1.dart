import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wemos_app/controller/dataTableController.dart';

class DataTableScreen1 extends StatelessWidget {
  final DataTableController controller = Get.put(DataTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Warna border
                          width: 2.0, // Ketebalan border
                        ),
                        borderRadius:
                            BorderRadius.circular(8.0), // Sudut border
                      ),
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label:
                                  Text('No', style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Timestamp',
                                  style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Kualitas Udara (%)',
                                  style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Kelembapan Tanah (%)',
                                  style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Suhu (°C)',
                                  style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Kelembapan Udara (%)',
                                  style: TextStyle(fontSize: 14))),
                          DataColumn(
                              label: Text('Suhu Tanah (°C)',
                                  style: TextStyle(fontSize: 14))),
                        ],
                        rows: controller.dataRecords
                            .map(
                              (record) => DataRow(
                                cells: [
                                  DataCell(Text(record['recordNumber']!)),
                                  DataCell(Text(record['timestamp']!)),
                                  DataCell(Text(record['kondisiUdara']!)),
                                  DataCell(Text(record['kelembapanTanah']!)),
                                  DataCell(Text(record['t']!)),
                                  DataCell(Text(record['kelembapanUdara']!)),
                                  DataCell(Text(record['suhuTanah']!)),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
