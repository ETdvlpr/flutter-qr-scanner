import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/core/enums/common_enums.dart';
import 'package:scanner/core/models/freezed_models.dart';
import 'package:scanner/core/services/file_service.dart';

class QRController extends GetxService {
  final FileService fileService;
  QRController({required this.fileService});

  QRViewController? cameraController;
  final status = Status.success.obs;

  @override
  void onInit() async {
    super.onInit();
    await requestCameraPermission();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      showOpenSettingsDialog();
    } else if (!status.isGranted || status.isDenied) {
      if (await Permission.camera.request().isPermanentlyDenied) {
        showOpenSettingsDialog();
      }
    }
  }

  void showOpenSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Permission Required"),
        content:
            const Text("Please grant camera permission to scan the barcode."),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  bool isValidGTIN(Barcode input) {
    if (input.code == null) return false;
    return input.format == BarcodeFormat.dataMatrix ||
        input.format == BarcodeFormat.ean13;
    // RegExp regex = RegExp(r'^\d{13,14}$');
    // return regex.hasMatch(input);
  }
//
  // Future<void> selectAndScanFromGallery() async {
  //   status.value = Status.loading;
  //   cameraController?.pauseCamera();
  //   final file = await fileService.selectFile(source: ImageSource.gallery);
  //   if (file != null) {
  //     final barcode = await processImage(file);
  //     print("barcode: $barcode");
  //     processBarcode(barcode);
  //   }
  //   status.value = Status.error;
  //   cameraController?.resumeCamera();
  // }

  // Future<String?> processImage(File file) async {
  //   try {
  //     final bytes = await File(file.path).readAsBytes();
  //     final image = decodeImage(Uint8List.fromList(bytes));

  //     if (image != null && image.data != null) {
  //       final source = RGBLuminanceSource(
  //         image.width,
  //         image.height,
  //         Int32List.fromList(
  //             image.data!.buffer.asUint8List()), // Convert to Int32List
  //       );
  //       final bitmap = BinaryBitmap(HybridBinarizer(source));
  //       final reader = QRCodeReader();
  //       final result = reader.decode(bitmap);
  //       return result.text;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   return null;
  // }

  void toggleFlash() {
    cameraController?.toggleFlash();
  }

  void onQRViewCreated(QRViewController controller) {
    cameraController = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      final barcode = scanData;
      print("barcode: ${barcode.format} : ${barcode.code}");
      processBarcode(barcode);
    });
  }

  void processBarcode(Barcode barCode) {
    if (isValidGTIN(barCode)) {
      cameraController?.pauseCamera();
      cameraController?.dispose();
      HapticFeedback.vibrate();
      ScannedItem? item;
      if (barCode.format == BarcodeFormat.ean13) {
        item = ScannedItem(gtin: barCode.code!, scanTime: DateTime.now());
      } else if (barCode.format == BarcodeFormat.dataMatrix) {
        final parser = GS1BarcodeParser.defaultParser();
        final parsedCode = parser.parse(barCode.code!);
        if (parsedCode.elements.containsKey('01')) {
          item = ScannedItem(
            gtin: parsedCode.elements['01']!.data,
            description: barCode.code!,
            scanTime: DateTime.now(),
          );
        }
      }
      Get.back(result: item);
    } else {
      Get.snackbar(
        "Error",
        "No valid GS1 GTIN-13 or GTIN-14 code found",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
