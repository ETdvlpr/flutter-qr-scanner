import 'package:scanner/core/services/file_service.dart';
import 'package:scanner/ui/controllers/qr_controller.dart';
import 'package:get/get.dart';

/*
  Binding and DI for QR flow.
*/
class QRBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FileService());
    Get.lazyPut(() => QRController(fileService: Get.find()));
  }
}
