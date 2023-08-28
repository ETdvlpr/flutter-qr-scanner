import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:scanner/core/adapters/repository_adapter.dart';
import 'package:scanner/core/models/freezed_models.dart';
import 'package:scanner/core/services/api/api_client.dart';
import 'package:scanner/utils/constants.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.apiClient});

  final ApiClient apiClient;
  final box = GetStorage();

  @override
  Future<void> addScannedItem(ScannedItem item) async {
    final List<ScannedItem> items = await getScannedItems();
    items.add(item);
    await box.write(kScannedItemBoxName, jsonEncode(items));
  }

  @override
  Future<List<ScannedItem>> getScannedItems() async {
    final String? itemsJson = box.read(kScannedItemBoxName);
    if (itemsJson == null) {
      return [];
    }

    final List<dynamic> decodedJson = jsonDecode(itemsJson);
    final List<ScannedItem> scannedItems = decodedJson
        .map<ScannedItem>((item) => ScannedItem.fromJson(item))
        .toList();

    return scannedItems;
  }
}
