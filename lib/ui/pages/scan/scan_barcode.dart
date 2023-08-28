import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/core/enums/common_enums.dart';
import 'package:scanner/ui/controllers/qr_controller.dart';
import 'package:scanner/ui/pages/scan/components/custom_overlay.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRController controller = Get.find();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.cameraController?.pauseCamera();
    } else if (Platform.isIOS) {
      controller.cameraController?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          // IconButton(
          //   onPressed: controller.selectAndScanFromGallery,
          //   icon: const Icon(Icons.photo_library),
          // ),
          // IconButton(
          //   onPressed: controller.flipCamera,
          //   icon: const Icon(Icons.flip_camera_android),
          // ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.flash_on),
            iconSize: 32.0,
            onPressed: controller.toggleFlash,
          ),
        ],
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: controller.onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              cutOutBottomOffset: height,
              borderWidth: 10,
              cutOutWidth:
                  MediaQuery.of(context).size.width - paddingHorizontal,
              cutOutHeight: height,
            ),
            formatsAllowed: const [
              BarcodeFormat.ean13,
              BarcodeFormat.dataMatrix,
            ],
          ),
          Obx(
            () => CustomOverlay(
              showLineAnimation: controller.status.value != Status.loading,
            ),
          ),
          Obx(
            () => controller.status.value == Status.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.cameraController?.dispose();
    super.dispose();
  }
}
