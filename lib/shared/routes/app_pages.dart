import 'package:scanner/ui/bindings/auth_binding.dart';
import 'package:scanner/ui/bindings/home_binding.dart';
import 'package:scanner/ui/bindings/qr_binding.dart';
import 'package:scanner/ui/pages/home/home_page.dart';
import 'package:scanner/ui/pages/introduction/initial_page.dart';
import 'package:scanner/ui/pages/scan/scan_barcode.dart';
import 'package:get/route_manager.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    // Introduction pages
    GetPage(
      name: Routes.initial,
      page: () => const InitialPage(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.scanQr,
      page: () => const QrScanner(),
      binding: QRBinding(),
    ),
  ];
}
