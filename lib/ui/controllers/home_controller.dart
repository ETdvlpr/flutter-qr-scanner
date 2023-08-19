import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs1_barcode_parser/gs1_barcode_parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/enums/common_enums.dart';
import 'package:scanner/core/models/freezed_models.dart';
import 'package:scanner/shared/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';

/*
  Handles any business logic and data binding with Home flow
  any home api requests are made here
*/
class HomeController extends GetxService {
  final IHomeRepository repository;
  HomeController({required this.repository});

  final status = Status.success.obs;

  final RxList<ScannedItem> _scannedItems = <ScannedItem>[].obs;
  List<ScannedItem> get scannedItems => _scannedItems.toList();
  set scannedItems(List<ScannedItem> value) => _scannedItems.assignAll(value);

  final Rx<String?> lastScannedItem = Rx<String?>(null);

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    getScannedItems();
  }

  Future<void> addScannedItem(ScannedItem item) async {
    await repository.addScannedItem(item);
    await getScannedItems();
  }

  Future<void> getScannedItems() async {
    status(Status.loading);
    final items = await repository.getScannedItems();
    scannedItems = items;
    status(Status.success);
  }

  Future<void> exportScannedItemsToCsv() async {
    final List<List<String>> dataRows = <List<String>>[];
    dataRows.add(<String>['Barcode']);
    for (final item in scannedItems) {
      dataRows.add(<String>[
        item.gtin!,
      ]);
    }
    await exportDataToCsv(dataRows);
  }

  Future<void> exportDataToCsv(List<List<String>> dataRows) async {
    final directory = await getTemporaryDirectory();

    final csvFile = File('${directory.path}/exported_data.csv');
    final csvSink = csvFile.openWrite();

    for (final row in dataRows) {
      csvSink.writeln(row.map((e) => '"$e"').join(','));
    }
    print(csvSink.toString());

    await csvSink.flush();
    await csvSink.close();
    await Share.shareXFiles(
      [
        XFile(
          csvFile.path,
          name: 'exported_data.csv',
          mimeType: "text/csv",
          bytes: csvFile.readAsBytesSync(),
        )
      ],
      subject: "Exported Data",
    );
    // // find or create download directory
    // if (Platform.isIOS || Platform.isAndroid) {
    //   final status = await Permission.storage.status;
    //   if (!status.isGranted || status.isDenied) {
    //     await Permission.mediaLibrary.request();
    //   }
    // }
    // String? downloadsDirectory;
    // if (Platform.isAndroid) {
    //   PermissionStatus status = await Permission.storage.status;
    //   if (status.isPermanentlyDenied) {
    //     showOpenSettingsDialog();
    //     return;
    //   }
    //   if (status.isGranted || status.isLimited) {
    //     downloadsDirectory = "/storage/emulated/0/Download/";
    //   } else {
    //     if (await Permission.storage.request().isPermanentlyDenied) {
    //       showOpenSettingsDialog();
    //       return;
    //     }
    //   }
    //   downloadsDirectory = "/storage/emulated/0/Download/";
    // } else {
    //   downloadsDirectory =
    //       await getDownloadsDirectory().then((value) => value?.path);
    // }
    // try {
    //   final file = File(downloadsDirectory! + 'exported_data.csv');
    //   await file.writeAsBytes(await csvFile.readAsBytes());
    //   Get.snackbar(
    //     "Exported",
    //     "Data exported to ${downloadsDirectory}exported_data.csv",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // } catch (e) {
    //   Get.snackbar(
    //     "Error",
    //     "Error exporting data $e",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  void scrollToListItem(ScannedItem item) {
    final index = scannedItems.indexOf(item);
    if (index != -1) {
      scrollController.animateTo(
        index * 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onScanPressed() async {
    ScannedItem? item = await Get.toNamed(Routes.scanQr) as ScannedItem?;
    if (item != null) {
      //check if item already exists
      ScannedItem? existingItem = scannedItems.firstWhereOrNull(
        (element) => element.gtin == item.gtin,
      );
      if (existingItem != null) {
        lastScannedItem.value = existingItem.gtin;
        scrollToListItem(existingItem);
        Get.snackbar(
          "Already Scanned",
          "This item has already been scanned",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        lastScannedItem.value = item.gtin;
        addScannedItem(item);
      }
    }
  }

  void showOpenSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
          "Please grant storage permission to export the data",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
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

  showItemDescription(ScannedItem item) {
    if (item.description == null) return;
    final parser = GS1BarcodeParser.defaultParser();
    final gs1Data = parser.parse(item.description!);
    print(gs1Data);
    final Map<String, String> data = gs1Data.elements.map(
      (key, value) => MapEntry(
        "${AI.AIS[key]!.dataTitle} :",
        _display(value.data),
      ),
    );

    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "GS1 DataMatrix Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              for (var entry in data.entries)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(entry.value),
                    const SizedBox(height: 8),
                  ],
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _display(dynamic value) {
    if (value is DateTime) {
      //format as expiry date
      return DateFormat("dd/MM/yyyy").format(value);
    } else if (value is List) {
      return value.join(", ");
    } else {
      return value.toString();
    }
  }
}
