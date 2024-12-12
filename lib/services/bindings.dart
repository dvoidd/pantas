import 'package:get/get.dart';
import 'package:wemos_app/controller/chartController.dart';
import 'package:wemos_app/controller/dataTableController.dart';

class appBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChartController());
    Get.lazyPut<DataTableController>(() => DataTableController());
  }
}
