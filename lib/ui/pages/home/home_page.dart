import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanner/ui/controllers/home_controller.dart';
import 'package:scanner/ui/widgets/scan_item_tile.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barcode Scanner"),
        actions: [
          Obx(
            () => controller.scannedItems.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: controller.exportScannedItemsToCsv,
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getScannedItems();
        },
        child: Obx(
          () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.scannedItems.length,
            itemBuilder: (context, index) {
              final item = controller.scannedItems[index];
              return Obx(
                () => ScannedItemListItem(
                  item: item,
                  isHighlighted: controller.lastScannedItem.value == item.gtin,
                  onTap: item.description?.isNotEmpty ?? false
                      ? () => controller.showItemDescription(item)
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onScanPressed,
        child: const Icon(Icons.barcode_reader),
      ),
    );
  }
}
