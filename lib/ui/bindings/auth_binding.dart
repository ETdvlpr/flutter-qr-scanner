import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/repository/auth_repository.dart';
import 'package:scanner/core/services/api/api_client.dart';
import 'package:scanner/ui/controllers/auth_controller.dart';

/*
  Binding and Dependency injection with lazy initialization for Auth flow,
  using get package
*/
class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(), fenix: true);
    Get.lazyPut(() => ApiClient(dio: Get.find()), fenix: true);
    Get.lazyPut<IAuthRepository>(() => AuthRepository(apiClient: Get.find()));
    Get.lazyPut(() => AuthController(repository: Get.find()));
  }
}
