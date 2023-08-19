import 'package:get/get.dart';
import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/repository/home_repository.dart';
import 'package:scanner/ui/controllers/home_controller.dart';

/*
  Binding and DI for home flow.
*/
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHomeRepository>(() => HomeRepository(apiClient: Get.find()),
        fenix: true);
    Get.lazyPut(() => HomeController(repository: Get.find()));
  }
}
